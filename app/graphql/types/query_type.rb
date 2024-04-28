# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # List Queries
    field :menus, [Types::MenuType],
          null: false, description: 'Returns a the list of available menus'

    def menus
      Menu.all
    end

    field :menu_sections, [Types::MenuSectionType],
          null: false,
          description: 'Returns the list of available menu sections'

    def menu_sections
      MenuSection.all
    end

    field :modifier_groups, [Types::ModifierGroupType],
          null: false,
          description: 'Returns the list of available modifier group types'

    def modifier_groups
      ModifierGroup.all
    end

    field :modifiers, [Types::ModifierType],
          null: false, description: 'Returns the list of available modifiers'

    def modifiers
      Modifier.all
    end

    field :section_items, [Types::SectionItemType],
          null: false,
          description: 'Returns the list of available section items'

    def section_items
      SectionItem.all
    end

    field :sections, [Types::SectionType],
          null: false, description: 'Returns the list of available sections'

    def sections
      Sections.all
    end

    field :items, [Types::ItemType],
          null: false, description: 'Returns the list of available items'

    def items
      Item.all
    end

    field :item_modifier_groups, [Types::ItemModifierGroupType],
          null: false,
          description: 'Returns the list of available item modifier groups'

    def item_modifier_groups
      ItemModifierGroup.all
    end

    # Individual queries (only for those with identifiers)
    field :menu, Types::MenuType,
          null: true, description: 'Returns menu with corresponding identifier' do
      argument :identifier, String, required: true
    end

    def menu(identifier:)
      Menu.find_by(identifier:)
    end

    field :modifier_group, Types::ModifierGroupType,
          null: true,
          description: 'Returns modifier group type with corresponding identifier' do
      argument :identifier, String, required: true
    end

    def modifier_group(identifier:)
      ModifierGroup.find_by(identifier:)
    end

    field :item, Types::ItemType,
          null: true, description: 'Returns item with corresponding identifier' do
      argument :identifier, String, required: true
    end

    def item(identifier:)
      Item.find_by(identifier:)
    end

    field :section, Types::SectionType,
          null: true, description: 'Returns section with corresponding identifier' do
      argument :identifier, String, required: true
    end

    def section(identifier:)
      Section.find_by(identifier:)
    end
  end
end
