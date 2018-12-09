
require('pry')

require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')


Customer.delete_all()
Film.delete_all()
Screening.delete_all()

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


screening1 = Screening.new({ 'film_id' => film4.id, 'show_time' => '14:00' })
screening1.save
screening2 = Screening.new({ 'film_id' => film1.id, 'show_time' => '16:30' })
screening2.save
screening3 = Screening.new({ 'film_id' => film1.id, 'show_time' => '18:00' })
screening3.save
screening4 = Screening.new({ 'film_id' => film3.id, 'show_time' => '18:30' })
screening4.save
screening5 = Screening.new({ 'film_id' => film2.id, 'show_time' => '19:00' })
screening5.save

customer6.name = 'Mrs Potato Head'
customer5.funds = 100
customer6.update()
customer5.update()

film4.title = 'Peppa Pig'
film3.price = 7
film4.update()
film3.update()


customer1.buy_ticket(screening2)
customer1.buy_ticket(screening3)
customer2.buy_ticket(screening2)
customer2.buy_ticket(screening5)
customer3.buy_ticket(screening4)
customer4.buy_ticket(screening1)
customer5.buy_ticket(screening3)
customer6.buy_ticket(screening5)
customer6.buy_ticket(screening2)

# ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'screening_id' => screening1.id })
# ticket1.save()
# ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'screening_id' => screening2.id })
# ticket2.save()
# ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'screening_id' => screening3.id })
# ticket3.save()
# ticket4 = Ticket.new({ 'customer_id' => customer4.id, 'screening_id' => screening4.id })
# ticket4.save()
# ticket5 = Ticket.new({ 'customer_id' => customer5.id, 'screening_id' => screening1.id })
# ticket5.save()
# ticket6 = Ticket.new({ 'customer_id' => customer6.id, 'screening_id' => screening2.id })
# ticket6.save()

# ticket5.film_id = film3.id
# ticket5.update()

# customer2.ticket_count()
# customer2.films()
# film1.customer_count()

# screening1.film()
# screening1.customers()
# film1.customers()
# film1.screenings()
# film1.show_times()


# binding.pry
# nil
