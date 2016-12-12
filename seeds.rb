require_relative ('models/customers')
require_relative ('models/films')
require_relative ('models/tickets')

require ('pry')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Rory' , 'funds' => 10})
customer1.save()
customer2 = Customer.new({ 'name' => 'Amy', 'funds' => 6 })
customer2.save()

film1 = Film.new({ 'title' => 'Jaws', 'price' => 1})
film1.save()
film2 = Film.new({ 'title' => 'Jaw2', 'price' => 2})
film2.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save()

binding.pry
nil