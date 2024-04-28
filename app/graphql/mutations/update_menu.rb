# frozen_string_literal: true

module Mutations
  class UpdateMenu < BaseMutation
    description 'Updates a menu by id'

    field :menu, Types::MenuType, null: false

    argument :identifier, String, required: true
    argument :label, String, required: false
    argument :start_date, GraphQL::Types::ISO8601Date, required: false
    argument :end_date, GraphQL::Types::ISO8601Date, required: false
    argument :state, String, required: false

    def resolve(identifier:, **kwargs)
      menu = ::Menu.find_by(identifier:)
      raise GraphQL::ExecutionError, 'Menu not found' unless menu.present?

      unless menu.update(kwargs)
        raise GraphQL::ExecutionError.new 'Error updating menu',
                                          extensions: menu.errors.to_hash
      end

      { menu: }
    end
  end
end
