# frozen_string_literal: true

# Section contains a section of the menu, e.g. "Desserts", "Wines"
class Section < ApplicationRecord
  include StringIdentifiable

  # Associations
  has_many :menu_sections, dependent: :destroy
  has_many :section_items, -> { order(:display_order) }, dependent: :destroy

  # Assumption is this contains the section name, e.g. "Desserts"
  validates :label, presence: true
end
