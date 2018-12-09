
require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')
require_relative('customer')


class Screening

  attr_reader :id
  attr_accessor :film_id, :show_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @show_time = options['show_time']
  end


  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO screenings ( film_id, show_time ) VALUES ( $1, $2 ) RETURNING *"
    values = [@film_id, @show_time]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def film()
    sql = "SELECT films.* FROM
           films INNER JOIN screenings
           ON films.id = screenings.film_id WHERE film_id = $1"
    values = [@film_id]
    films = SqlRunner.run(sql, values)
    film = films.map { |film| Film.new(film) }
    return film[0]
  end

  def customers()
    sql = "SELECT customers.* FROM
           customers INNER JOIN tickets
           ON customers.id = tickets.customer_id INNER JOIN screenings
           ON tickets.screening_id = screenings.id WHERE screening_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
    #return customer.uniq { |i| i.id }
  end


end
