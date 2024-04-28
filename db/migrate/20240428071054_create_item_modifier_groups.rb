# frozen_string_literal: true

class CreateItemModifierGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :item_modifier_groups, id: false, primary_key: %i[item_id modifier_group_id] do |t|
      t.string :item_id, null: false
      t.string :modifier_group_id, null: false

      t.timestamps

      t.index %i[item_id modifier_group_id], unique: true
    end

    add_foreign_key :item_modifier_groups, :modifier_groups, column: :modifier_group_id, primary_key: :identifier
    add_foreign_key :item_modifier_groups, :items, column: :item_id, primary_key: :identifier
  end
end
