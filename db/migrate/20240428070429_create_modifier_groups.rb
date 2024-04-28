# frozen_string_literal: true

class CreateModifierGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :modifier_groups, id: false, primary_key: :identifier do |t|
      t.string :identifier, null: false
      t.string :label, null: false
      t.integer :selection_required_min, null: false, default: 0
      t.integer :selection_required_max, null: false, default: 1

      t.timestamps

      t.index :identifier, unique: true
    end
  end
end
