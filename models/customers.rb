require_relative('../db/sql_runner.rb')
require_relative('films')

class Customer

  attr_reader :id
  attr_accessor :funds, :name

  def initialize( options )
    @id = options['id'] unless options['id'].nil?
    @name = options['name']
    @funds = options['funds']
  end

  def self.get_many ( sql )
    customers = SqlRunner.run( sql )
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM customers"
    return Customer.get_many(sql)
  end


  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def save()
    sql = "
    INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING id
    "
    customer = SqlRunner.run( sql ).first
    @id = customer['id'].to_i
  end

  def delete()
    sql = "
    DELETE FROM customers WHERE id = #{@id}
    "
    SqlRunner.run(sql)
  end

  def count_tickets
      sql = "
      SELECT tickets.* FROM tickets
      WHERE customer_id = #{@id}
      "
      return SqlRunner.run( sql ).count
  end

  def count_films
      sql = "
      SELECT films.* FROM films
      INNER JOIN tickets ON tickets.film_id = films.id
      WHERE customer_id = #{@id}
      "
      return SqlRunner.run( sql ).count
  end

  def films()
    sql = "
    SELECT films.* FROM films
    INNER JOIN tickets ON tickets.film_id = films.id
    WHERE customer_id = #{@id}
    "
    return Film.get_many(sql)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end


end