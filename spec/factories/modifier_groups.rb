# frozen_string_literal: true

FactoryBot.define do
  factory :modifier_group do
    label { Faker::Food.ethnic_category }
  end
end
