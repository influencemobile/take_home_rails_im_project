FactoryBot.define do 
  factory :player do 
    age { Faker::Date.birthday(min_age: 18, max_age: 65) }
    first_name { Faker::Name.unique.name }
    gender { Faker::Number.number(digits: 1) % 2 == 0 ? 'Female' : 'Male' }
    username { Faker::Internet.unique.email }
  end
end