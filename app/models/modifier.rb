# frozen_string_literal: true

# Modifier is an option under ModifierGroup (e.g. Size: S, M, L)
class Modifier < ApplicationRecord
  include DisplayOrderable

  self.primary_key = %i[modifier_group_id item_id display_order]

  belongs_to :modifier_group
  belongs_to :item

  validates :modifier_group_id, presence: true
  validates :item_id, presence: true

  validate_display_order_for :modifier_group_id
  validates :default_quantity, numericality: { integer: true, greater_than_or_equal_to: 0 }

  # Assumption: If set, this will completely override the price set on item
  validates :price_override, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  validate :default_quantity_must_be_within_range

  private

  def default_quantity_must_be_within_range
    return unless default_quantity > modifier_group.selection_required_max

    errors.add(:default_quantity, "cannot be more than ModifierGroup's max selection")

    # No need to check against min as other modifiers may have been selected with default > 0
  end
end
