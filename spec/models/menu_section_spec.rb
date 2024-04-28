# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenuSection, type: :model do
  let!(:menu) { create :menu }
  let!(:section1) { create :section }
  let!(:section2) { create :section }

  before do
    create :menu_section, menu:, section: section1, display_order: 0
  end

  it 'does not allow another section with the same display_order within the same menu' do
    new_menu_section = build :menu_section, menu:, section: section2, display_order: 0
    expect(new_menu_section).to_not be_valid
  end

  it 'does not allow a section appearing twice' do
    new_menu_section = build :menu_section, menu:, section: section1, display_order: 1
    expect(new_menu_section).to_not be_valid
  end
end
