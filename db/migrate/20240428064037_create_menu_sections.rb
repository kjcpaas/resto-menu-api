# frozen_string_literal: true

class CreateMenuSections < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_sections, id: false, primary_key: %i[menu_id section_id display_order] do |t|
      t.string :menu_id, null: false
      t.string :section_id, null: false
      t.integer :display_order, default: 0

      t.timestamps

      t.index %i[menu_id section_id display_order], unique: true
    end

    add_foreign_key :menu_sections, :menus, column: :menu_id, primary_key: :identifier
    add_foreign_key :menu_sections, :sections, column: :section_id, primary_key: :identifier
  end
end
