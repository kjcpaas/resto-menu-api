# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items, id: false, primary_key: :identifier do |t|
      t.string :identifier, null: false
      t.string :type, null: false
      t.string :label, null: false
      t.string :description
      t.float :price, null: false

      t.timestamps

      t.index :identifier, unique: true
    end
  end
end
