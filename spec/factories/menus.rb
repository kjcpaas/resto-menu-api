# frozen_string_literal: true

FactoryBot.define do
  factory :menu do
    label { Faker::Restaurant.name }
    start_date { Time.now.to_date }
    end_date { rand(1..6).months.from_now }
  end
end
