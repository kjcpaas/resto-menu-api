# frozen_string_literal: true

FactoryBot.define do
  factory :modifier do
    association :modifier_group
    association :item, :component

    sequence(:display_order)
  end
end
