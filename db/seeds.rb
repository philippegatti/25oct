# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
	
	puts "Creating seed... it might require a few minutes"

	City.create(name:"Paris", zip_code: "75000")
	City.create(name:"Lyon", zip_code: "69000")
	City.create(name:"Marseille", zip_code: "13000")
	City.create(name:"Lille", zip_code: "59000")
	City.create(name:"Ajaccio", zip_code: "20000")
	puts "Cities created"

	20.times do
		User.create(phone_number: "0033"+rand(7).to_s+Faker::Number.number(digits: 8).to_s ,email: Faker::Internet.email,description: Faker::Lorem.paragraph)
	end
	puts "Users created"

	50.times do
		Listing.create(available_beds: rand(15), price: rand(15..1000), description: Faker::Lorem.paragraph_by_chars(number: 140), has_wifi: [true, false].sample, admin_id: User.all.sample.id, city_id: City.all.sample.id, welcome_message: Faker::Lorem.paragraph)
	end
	puts "Listings created"

 	Listing.all.each do |list| 
 		while list.reservations.count < 5
 			begin
 			Reservation.create(start_date: Faker::Date.backward(days: 365),end_date: Faker::Date.backward(days: 365),listing_id: list.id,invitee_id:User.all.sample.id)
 			rescue
 			end
 		end
 	end

 	puts "Backward reservations created"

 	Listing.all.each do |list| 
 		while list.reservations.count < 10
 			begin
 			Reservation.create(start_date: Faker::Date.forward(days: 365),end_date: Faker::Date.forward(days: 365),listing_id: list.id,invitee_id:User.all.sample.id)
 			rescue
 			end
 		end
 	end

 	puts "Forward reservations created"
 	puts "Seed completed"
 