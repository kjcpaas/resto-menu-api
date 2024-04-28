# frozen_string_literal: true

class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus, id: false, primary_key: :identifier do |t|
      t.string :identifier, null: false

      t.string :label, null: false
      t.string :state, null: false, default: 'draft'
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps

      t.index :identifier, unique: true
    end
  end
end
