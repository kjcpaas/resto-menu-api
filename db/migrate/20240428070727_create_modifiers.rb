# frozen_string_literal: true

class CreateModifiers < ActiveRecord::Migration[7.1]
  def change
    create_table :modifiers, id: false, primary_key: %i[modifier_group_id item_id display_order] do |t|
      t.string :modifier_group_id, null: false
      t.string :item_id, null: false
      t.integer :display_order, default: 0
      t.integer :default_quantity, default: 0
      t.float :price_override

      t.timestamps

      t.index %i[modifier_group_id item_id display_order], unique: true
    end

    add_foreign_key :modifiers, :modifier_groups, column: :modifier_group_id, primary_key: :identifier
    add_foreign_key :modifiers, :items, column: :item_id, primary_key: :identifier
  end
end
