# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Person.delete_all
Address.delete_all
Car.delete_all
Parking.delete_all
PlaceRent.delete_all
Account.delete_all

person1 = Person.create!(first_name: 'Anna', last_name: 'Nowak')
person2 = Person.create!(first_name: 'Janusz', last_name: 'Ygrekowski')
person3 = Person.create!(first_name: 'Tomasz', last_name: 'Kowalski')
car1 = Car.create!(registration_number: 'PZ12345', model: 'Fiat Punto', owner: person1)
car2 = Car.create!(registration_number: 'WE65432', model: 'Ford Escort', owner: person2)
address1 = Address.create!(city: 'Poznań', street: 'Św. Marcin', zip_code: '61-248')
address2 = Address.create!(city: 'Warszawa', street: 'Marszałkowska', zip_code: '00-300')
parking1 = Parking.create!(places: 100, kind: 'outdoor', hour_price: 3.5, day_price: 20.99, address: address1, owner: person1)
parking2 = Parking.create!(places: 50, kind: 'private', hour_price: 2.9, day_price: 12.99, address: address2, owner: person2)
place_rent1 = PlaceRent.create!(starts_at: '2016-01-24 08:15:34', ends_at: '2016-01-24 18:15:34', parking: parking1, car: car1)
place_rent2 = PlaceRent.create!(starts_at: '2016-02-24 10:15:34', ends_at: '2016-02-24 18:15:34', parking: parking2, car: car2)
place_rent3 = PlaceRent.create!(starts_at: '2016-01-24 10:15:34', ends_at: '2017-02-24 18:15:34', parking: parking1, car: car1)
account1 = Account.create!(email: 'anna.nowak@netguru.pl', password: 'password', person: person1)
account2 = Account.create!(email: 'admin@example.com', password: 'password123', person: person2)
account3 = Account.create!(email: 'nocar@example.com', password: 'password', person: person3)
