FactoryBot.define do 
  factory :offers_target do 
    age { Faker::Number.within(range: 18..65) }
    gender {Faker::Number.number(digits: 1) % 2 == 0 ? 'Female' : 'Male'}
    offer_id { Faker::Number.within(range: 1..100) }
    # sequence(:offer_id) { |n| "#{n}"}
  end
end
