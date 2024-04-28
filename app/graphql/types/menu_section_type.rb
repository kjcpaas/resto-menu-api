# frozen_string_literal: true

module Types
  class MenuSectionType < Types::BaseObject
    field :menu_id, String, null: false
    field :section_id, String, null: false
    field :display_order, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :menu, Types::MenuType, null: false
    field :section, Types::SectionType, null: false
  end
end
