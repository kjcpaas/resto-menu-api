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
end
