
require('pry')

require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')


customer1 = Customer.new({ 'name' => 'Woody', 'funds' => 100 })
customer1.save()

film1 = Film.new({ 'title' => 'The Magnificent Seven', 'price' => 10 })
film1.save()
