require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :price, :title

  def initialize( options )
    @id = options['id'] unless options['id'].nil?
    @title = options['title']
    @price = options['price']
  end

  def self.get_many( sql )
    films = SqlRunner.run( sql )
    result = films.map { |film| Film.new( film ) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM films"
    return Film.get_many(sql)
  end


  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def save()
    sql = "
    INSERT INTO films (title, price) VALUES  ('#{@title}', #{@price}) RETURNING id
    "
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end


  def delete()
    sql = "
    DELETE FROM films WHERE id = #{@id}
    "
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "
    SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE film_id = #{@id}
    "
    return Customer.get_many(sql)
  end

  def tickets_sold
      sql = "
      SELECT tickets.* FROM tickets
      WHERE film_id = #{@id}
      "
      return SqlRunner.run( sql ).count
  end

end