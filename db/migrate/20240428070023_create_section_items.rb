# frozen_string_literal: true

class CreateSectionItems < ActiveRecord::Migration[7.1]
  def change
    create_table :section_items, id: false, primary_key: %i[section_id item_id display_order] do |t|
      t.string :section_id, null: false
      t.string :item_id, null: false
      t.integer :display_order, default: 0

      t.timestamps

      t.index %i[section_id item_id display_order], unique: true
    end

    add_foreign_key :section_items, :sections, column: :section_id, primary_key: :identifier
    add_foreign_key :section_items, :items, column: :item_id, primary_key: :identifier
  end
end
