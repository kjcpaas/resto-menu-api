# frozen_string_literal: true

FactoryBot.define do
  factory :section do
    label { Faker::Food.ethnic_category }
    description { Faker::Food.description }
  end
end
