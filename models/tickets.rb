require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( options )
    @id = options['id'] unless options['id'].nil?
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def self.get_many ( sql )
    tickets = SqlRunner.run( sql )
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    return Ticket.get_many(sql)
  end


  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def save()
    sql = "
    INSERT INTO tickets (customer_id, film_id) VALUES ('#{@customer_id}', '#{@film_id}') RETURNING id
    "
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ('#{@customer_id}', '#{@film_id}') WHERE id = '#{@id}'"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "
    DELETE FROM tickets WHERE id = #{@id}
    "
    SqlRunner.run(sql)
  end

  def customers()
   sql = "
   SELECT FROM customers WHERE id = #{@customer_id}
   "
   result = SqlRunner.run( sql ).first
   return Customer.new(result)
  end

  def films()
    sql = "
    SELECT FROM films where id = #{@film_id}
    "
    result = SqlRunner.run ( sql ).first
    return Film.new(result)
  end

end