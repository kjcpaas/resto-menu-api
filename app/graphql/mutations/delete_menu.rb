# frozen_string_literal: true

module Mutations
  class DeleteMenu < BaseMutation
    description 'Deletes a menu by ID'

    field :menu, Types::MenuType, null: false

    argument :identifier, String, required: true

    def resolve(identifier:)
      menu = ::Menu.find_by(identifier:)
      raise GraphQL::ExecutionError, 'Menu not found' unless menu.present?
      raise GraphQL::ExecutionError.new 'Error deleting menu', extensions: menu.errors.to_hash unless menu.destroy!

      { menu: }
    end
  end
end
