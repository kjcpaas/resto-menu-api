# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'identifier' do
    it 'gets an identifier if new' do
      section = Section.new
      expect(section.identifier).to be_present
    end

    it 'does not change identifier when fetched from the db' do
      section = create(:section, label: 'Mains')

      expect(Section.where(label: 'Mains').first.identifier).to eq section.identifier
    end
  end

  describe 'section items' do
    let!(:section) { create :section }
    let!(:item1) { create :section_item, section:, display_order: 1 }
    let!(:item2) { create :section_item, section:, display_order: 0 }

    it 'orders according to display_order' do
      expect(section.section_items.count).to eq 2
      expect(section.section_items[0].display_order).to eq 0
      expect(section.section_items[1].display_order).to eq 1
    end
  end
end
