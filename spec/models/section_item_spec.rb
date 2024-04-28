# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SectionItem, type: :model do
  let!(:section) { create :section }
  let!(:item1) { create :item }
  let!(:item2) { create :item }

  before do
    create :section_item, section:, item: item1, display_order: 0
  end

  it 'does not allow another item with the same display_order within the same section' do
    new_section_item = build :section_item, section:, item: item2, display_order: 0
    expect(new_section_item).to_not be_valid
  end

  it 'does not allow a item appearing twice' do
    new_section_item = build :section_item, section:, item: item1, display_order: 1
    expect(new_section_item).to_not be_valid
  end
end
