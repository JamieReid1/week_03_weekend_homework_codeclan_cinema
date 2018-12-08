
require_relative('../db/sql_runner')


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
           films INNER JOIN tickets
           ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film) }
  end


end
