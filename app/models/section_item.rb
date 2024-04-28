# frozen_string_literal: true

# SectionItem represents the inclusion of an item in a Menu via a Section
class SectionItem < ApplicationRecord
  include DisplayOrderable

  self.primary_key = %i[section_id item_id display_order]

  belongs_to :section
  belongs_to :item

  validates :section_id, presence: true
  # Do not duplicate item within a section
  validates :item_id, presence: true, uniqueness: { scope: :section_id }

  validate_display_order_for :section_id
end
