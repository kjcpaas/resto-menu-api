# frozen_string_literal: true

module Types
  class ModifierGroupType < Types::BaseObject
    field :identifier, String, null: false
    field :label, String, null: false
    field :selection_required_min, Integer, null: false
    field :selection_required_max, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :modifiers, [Types::ModifierType], null: false
    field :item_modifier_groups, [Types::ItemModifierGroupType], null: false
  end
end
