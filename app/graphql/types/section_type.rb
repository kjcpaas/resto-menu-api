# frozen_string_literal: true

module Types
  class SectionType < Types::BaseObject
    field :identifier, String, null: false
    field :label, String, null: false
    field :description, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :section_items, [Types::SectionItemType], null: false
  end
end
