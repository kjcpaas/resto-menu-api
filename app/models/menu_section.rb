# frozen_string_literal: true

# MenuSection connects the Menu with the sections
class MenuSection < ApplicationRecord
  include DisplayOrderable

  self.primary_key = %i[menu_id section_id display_order]

  belongs_to :menu
  belongs_to :section

  validates :menu_id, presence: true
  # Do not duplicate section within a menu
  validates :section_id, presence: true, uniqueness: { scope: :menu_id }

  validate_display_order_for :menu_id
end
