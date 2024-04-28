# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'identifier' do
    it 'gets an identifier if new' do
      item = Item.new
      expect(item.identifier).to be_present
    end

    it 'does not change identifier when fetched from the db' do
      item = create(:item, label: 'Ramen')

      expect(Item.where(label: 'Ramen').first.identifier).to eq item.identifier
    end
  end

  describe 'validations' do
    it 'is valid when expected attributes are passed' do
      item = FactoryBot.build(:item)
      expect(item).to be_valid
    end

    it 'is not valid when an unknown type used' do
      item = build(:item, type: 'Promo')
      expect(item).to_not be_valid
    end

    it 'is not valid when price is negative' do
      item = build(:item, price: -0.10)
      expect(item).to_not be_valid
    end
  end
end
