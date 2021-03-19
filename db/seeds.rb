require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 10.times { |i|
#   Player.create({ username: Faker::Internet.unique.email, first_name: Faker::Name.unique.name, gender: i % 2 == 0 ? 'Female' : 'Male', age: Faker::Date.birthday(min_age: 18, max_age: 65)})
# }
# 100.times { |i|
#   Offer.create({ description: Faker::Marketing.buzzwords})
# }
100.times { |i|
  OffersTarget.create({ age: Faker::Number.within(range: 18..65), gender: i % 2 == 0 ? 'Female' : 'Male', offer_id: i})
}
