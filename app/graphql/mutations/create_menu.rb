# frozen_string_literal: true

module Mutations
  class CreateMenu < BaseMutation
    description 'Creates a new menu'

    field :menu, Types::MenuType, null: false

    argument :label, String, required: true
    argument :start_date, GraphQL::Types::ISO8601Date, required: true
    argument :end_date, GraphQL::Types::ISO8601Date, required: true
    argument :state, String, required: false

    def resolve(**kwargs)
      menu = ::Menu.new(kwargs.slice(:label, :start_date, :end_date))
      menu.state = kwargs[:state] if kwargs[:state].present?
      raise GraphQL::ExecutionError.new 'Error creating menu', extensions: menu.errors.to_hash unless menu.save

      { menu: }
    end
  end
end
