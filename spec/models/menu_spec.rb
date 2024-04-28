# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'identifier' do
    it 'gets an identifier if new' do
      menu = Menu.new
      expect(menu.identifier).to be_present
    end

    it 'does not change identifier when fetched from the db' do
      menu = create(:menu, label: 'Test Kitchen')

      expect(Menu.where(label: 'Test Kitchen').first.identifier).to eq menu.identifier
    end
  end

  describe 'menu sections' do
    let!(:menu) { create :menu }
    let!(:section1) { create :menu_section, menu:, display_order: 1 }
    let!(:section2) { create :menu_section, menu:, display_order: 0 }

    it 'orders according to display_order' do
      expect(menu.menu_sections.count).to eq 2
      expect(menu.menu_sections[0].display_order).to eq 0
      expect(menu.menu_sections[1].display_order).to eq 1
    end
  end

  describe 'validations' do
    it 'is valid when expected attributes are passed' do
      menu = FactoryBot.build(:menu)
      expect(menu).to be_valid
    end

    it 'is not valid when an unknown state used' do
      menu = build(:menu, state: 'unknown')
      expect(menu).to_not be_valid
    end

    it 'is not valid when any of the dates are blank' do
      menu_no_start = build(:menu, start_date: nil)
      expect(menu_no_start).to_not be_valid

      menu_no_end = build(:menu, end_date: nil)
      expect(menu_no_end).to_not be_valid
    end

    it 'is not valid when end date is before start date' do
      menu = build(:menu, end_date: 1.day.ago.to_date, start_date: Time.now.to_date)
      expect(menu).to_not be_valid
    end
  end
end
