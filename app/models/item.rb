# frozen_string_literal: true

# Item represents a complete SKU available for sale. Can be a Product or Component
class Item < ApplicationRecord
  include StringIdentifiable

  has_many :item_modifier_group, dependent: :destroy
  has_many :section_item, dependent: :destroy

  validates :type, presence: true, inclusion: { in: %w[Product Component] }

  # Assumption is this is the menu title so this must not be blank
  validates :label, presence: true

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
