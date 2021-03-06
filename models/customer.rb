
require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')
require_relative('screening')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO customers ( name, funds ) VALUES ( $1, $2 ) RETURNING *"
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.return_all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map { |customer| self.new(customer) }
  end

  def self.return_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  def self.return_by_name(name)
    sql = "SELECT * FROM customers WHERE name = $1"
    values = [name]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  def update()
    sql = "UPDATE customers SET ( name, funds ) = ( $1, $2 ) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM
           films INNER JOIN screenings
           ON films.id = screenings.film_id INNER JOIN tickets
           ON screenings.id = tickets.screening_id WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    film = films.map { |film| Film.new(film) }
    return film.uniq { |i| i.id }
  end

  def buy_ticket(screening)
    ticket = Ticket.new({ 'customer_id' => @id, 'screening_id' => screening.id })
    ticket.save()
    sql = "SELECT films.* FROM
           films INNER JOIN screenings
           ON films.id = screenings.film_id INNER JOIN tickets
           ON screenings.id = tickets.screening_id WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql ,values)
    film = films.map { |film| Film.new(film) }
    @funds -= film[0].price
    update()
  end

  def ticket_count()
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    ticket_arr = tickets.map { |ticket| Ticket.new(ticket) }
    return ticket_arr.length
  end


end
