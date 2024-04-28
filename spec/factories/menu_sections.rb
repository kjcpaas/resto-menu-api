# frozen_string_literal: true

FactoryBot.define do
  factory :menu_section do
    association :menu
    association :section

    sequence(:display_order)
  end
end
