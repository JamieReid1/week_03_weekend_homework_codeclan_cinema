
require_relative('../db/sql_runner')
require_relative('customer')
require_relative('film')
require_relative('screening')


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO tickets ( customer_id, screening_id) VALUES ( $1, $2 ) RETURNING *"
    values = [@customer_id, @screening_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.return_all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return tickets.map { |ticket| self.new(ticket) }
  end

  def self.return_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    ticket = SqlRunner.run(sql, values).first
    return Ticket.new(ticket)
  end

  def update()
    sql = "UPDATE tickets SET ( customer_id, screening_id ) = ( $1, $2 ) WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end


end
