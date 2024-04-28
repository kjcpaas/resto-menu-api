# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModifierGroup, type: :model do
  describe 'identifier' do
    it 'gets an identifier if new' do
      modifier_group = ModifierGroup.new
      expect(modifier_group.identifier).to be_present
    end

    it 'does not change identifier when fetched from the db' do
      modifier_group = create(:modifier_group, label: 'Ramen Toppings')

      expect(ModifierGroup.where(label: 'Ramen Toppings').first.identifier).to eq modifier_group.identifier
    end
  end

  describe 'modifiers' do
    let!(:modifier_group) { create :modifier_group }
    let!(:item1) { create :modifier, modifier_group:, display_order: 1 }
    let!(:item2) { create :modifier, modifier_group:, display_order: 0 }

    it 'orders according to display_order' do
      expect(modifier_group.modifiers.count).to eq 2
      expect(modifier_group.modifiers[0].display_order).to eq 0
      expect(modifier_group.modifiers[1].display_order).to eq 1
    end
  end

  describe 'validations' do
    it 'does not allow negative selection' do
      mg_neg_min = build(:modifier_group, selection_required_min: -1)
      expect(mg_neg_min).to_not be_valid

      mg_neg_max = build(:modifier_group, selection_required_min: -3, selection_required_max: -1)
      expect(mg_neg_max).to_not be_valid
    end

    it 'does not allow max to be less than min' do
      mg = build(:modifier_group, selection_required_min: 1, selection_required_max: 0)
      expect(mg).to_not be_valid
    end
  end
end
