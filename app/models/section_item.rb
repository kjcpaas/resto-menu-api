# frozen_string_literal: true

# SectionItem represents the inclusion of an item in a Menu via a Section
class SectionItem < ApplicationRecord
  include DisplayOrderable

  self.primary_key = %i[section_id item_id display_order]

  belongs_to :section
  belongs_to :item

  validates :section_id, presence: true
  validates :item_id, presence: true

  validate_display_order_for :section_id
end
