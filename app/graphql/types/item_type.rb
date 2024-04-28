# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :identifier, String, null: false
    field :type, String, null: false
    field :label, String, null: false
    field :description, String
    field :price, Float, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :item_modifier_groups, [Types::ItemModifierGroupType], null: false
    field :section_items, [Types::SectionItemType], null: false
  end
end
