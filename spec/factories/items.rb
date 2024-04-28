# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    label { Faker::Food.dish }
    description { Faker::Food.description }
    price { Faker::Number.decimal(l_digits: 2) }
    type { %w[Component Product].sample }

    trait :component do
      type { 'Component' }
    end

    trait :product do
      type { 'Product' }
    end
  end
end
