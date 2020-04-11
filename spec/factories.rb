FactoryBot.define do
  factory :random_currency, class: Currency do
    name { Faker::Currency.name }
    rate { rand(10000).to_f/100 }
  end
end