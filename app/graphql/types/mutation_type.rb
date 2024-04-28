# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :update_menu, mutation: Mutations::UpdateMenu
    field :delete_menu, mutation: Mutations::DeleteMenu
    field :create_menu, mutation: Mutations::CreateMenu
  end
end
