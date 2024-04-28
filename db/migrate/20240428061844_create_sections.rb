# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections, id: false, primary_key: :identifier do |t|
      t.string :identifier, null: false
      t.string :label, null: false
      t.string :description

      t.timestamps

      t.index :identifier, unique: true
    end
  end
end
