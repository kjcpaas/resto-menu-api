# frozen_string_literal: true

# ModifierGroup includes modifier for an item (e.g. size, pizza topping)
class ModifierGroup < ApplicationRecord
  include StringIdentifiable

  # Associations
  has_many :modifiers, -> { order(:display_order) }, dependent: :destroy
  has_many :item_modifier_groups, dependent: :destroy

  # Assumption is this is the name of the modifier group so it cannot be blank
  validates :label, presence: true

  validates :selection_required_min, presence: true, numericality: { integer: true, greater_than_or_equal_to: 0 }
  validates :selection_required_max, presence: true, numericality: { integer: true, greater_than_or_equal_to: 0 }

  validate :selection_range_is_valid

  private

  def selection_range_is_valid
    return unless selection_required_max < selection_required_min

    errors.add(:selection_required_max, 'must not be less than selection_required_min')
  end
end
