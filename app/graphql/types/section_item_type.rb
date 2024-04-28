# frozen_string_literal: true

module Types
  class SectionItemType < Types::BaseObject
    field :section_id, String, null: false
    field :item_id, String, null: false
    field :display_order, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :section, Types::SectionType, null: false
    field :item, Types::ItemType, null: false
  end
end
