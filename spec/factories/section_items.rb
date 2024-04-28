# frozen_string_literal: true

FactoryBot.define do
  factory :section_item do
    association :section
    association :item

    sequence(:display_order)
  end
end
