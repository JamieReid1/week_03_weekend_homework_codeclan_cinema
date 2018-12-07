
require_relative('../db/sql_runner')


class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO films ( title, price ) VALUES ( $1, $2 ) RETURNING *"
    values = [@title, @price]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.return_all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map { |film| self.new(film) }
  end

  def self.return_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end

  def self.return_by_title(title)
    sql = "SELECT * FROM films WHERE title = $1"
    values = [title]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end


end
