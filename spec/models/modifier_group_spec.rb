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
