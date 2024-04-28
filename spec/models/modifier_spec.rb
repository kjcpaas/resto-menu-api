# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Modifier, type: :model do
  let!(:modifier_group) { create :modifier_group, selection_required_max: 2 }

  it 'does not allow default_quantity to be greater than ModifierGroup selection_required_max' do
    modifier = build(:modifier, modifier_group:, default_quantity: 3)
    expect(modifier).to_not be_valid
  end
end
