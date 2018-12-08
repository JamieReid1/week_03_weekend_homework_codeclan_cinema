
require('pry')

require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')


Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({ 'name' => 'Woody', 'funds' => 100 })
customer1.save()
customer2 = Customer.new({ 'name' => 'Buzz Lightyear', 'funds' => 100 })
customer2.save()
customer3 = Customer.new({ 'name' => 'Rex', 'funds' => 90 })
customer3.save()
customer4 = Customer.new({ 'name' => 'Hamm', 'funds' => 90 })
customer4.save()
customer5 = Customer.new({ 'name' => 'Little Bo Peep', 'funds' => 90 })
customer5.save()
customer6 = Customer.new({ 'name' => 'Mr Potato Head', 'funds' => 90 })
customer6.save()

film1 = Film.new({ 'title' => 'The Magnificent Seven', 'price' => 9 })
film1.save()
film2 = Film.new({ 'title' => 'Transformers', 'price' => 10 })
film2.save()
film3 = Film.new({ 'title' => 'Jurassic Park', 'price' => 8 })
film3.save()
film4 = Film.new({ 'title' => 'Babe', 'price' => 7 })
film4.save()

# ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
# ticket1.save()
# ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id })
# ticket2.save()
# ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id })
# ticket3.save()
# ticket4 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film4.id })
# ticket4.save()
# ticket5 = Ticket.new({ 'customer_id' => customer5.id, 'film_id' => film1.id })
# ticket5.save()
# ticket6 = Ticket.new({ 'customer_id' => customer6.id, 'film_id' => film2.id })
# ticket6.save()

customer1.buy_ticket(film1)
customer2.buy_ticket(film2)
customer3.buy_ticket(film3)
customer4.buy_ticket(film4)
customer5.buy_ticket(film1)
customer6.buy_ticket(film2)
customer2.buy_ticket(film1)

customer6.name = 'Mrs Potato Head'
customer5.funds = 100
customer6.update()
customer5.update()

film4.title = 'Peppa Pig'
film3.price = 7
film4.update()
film3.update()

# ticket5.film_id = film3.id
# ticket5.update()

customer2.ticket_count()



binding.pry
nil
