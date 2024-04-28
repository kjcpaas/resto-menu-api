# frozen_string_literal: true

# ItemModifierGroup connects a ModifierGroup to an Item
class ItemModifierGroup < ApplicationRecord
  self.primary_key = %i[item_id modifier_group_id]

  # Associations
  belongs_to :item
  belongs_to :modifier_group

  validates :item_id, presence: true
  validates :modifier_group_id, presence: true
end
