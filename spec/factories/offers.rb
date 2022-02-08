FactoryBot.define do 
  factory :offer do 
    description { Faker::Marketing.buzzwords }
  end
end
