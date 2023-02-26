# frozen_string_literal: true

require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |i|
  Player.create({ username: Faker::Internet.unique.email, first_name: Faker::Name.unique.name,
                  gender: i.even? ? 'Female' : 'Male', age: Faker::Date.birthday(min_age: 18, max_age: 65) })
end
100.times do |_i|
  Offer.create({ description: Faker::Marketing.buzzwords })
end
100.times do |i|
  OffersTarget.create({ age: Faker::Number.within(range: 18..65), gender: i.even? ? 'Female' : 'Male', offer_id: i })
end
