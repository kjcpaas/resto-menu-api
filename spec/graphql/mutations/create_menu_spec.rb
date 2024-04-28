# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateMenu, type: :request do
  def read_graphql_mutation_fixture_file(filename)
    File.read(File.join('spec', 'fixtures', 'graphql', 'mutations', filename))
  end

  let(:query_template) { ERB.new(read_graphql_mutation_fixture_file('create_menu.gql.erb')) }
  let(:query) do
    query_template.result_with_hash({
      label: nil,
      start_date: nil,
      end_date: nil,
      state: nil
    }.merge(query_attrs))
  end

  subject do
    post '/graphql', params: { query: }
  end

  describe 'with valid inputs' do
    let(:attrs) { attributes_for :menu }
    let(:query_attrs) do
      {
        label: attrs[:label],
        start_date: attrs[:start_date].strftime('%Y-%m-%d'),
        end_date: attrs[:end_date].strftime('%Y-%m-%d')
      }
    end

    subject do
      post '/graphql', params: { query: }
    end

    it 'creates a new menu item' do
      expect { subject }.to change(Menu, :count).by 1
    end

    it 'creates menu with the supplied values' do
      subject

      puts JSON.parse(response.body)
    end
  end

  describe 'blank dates' do
    let(:query_attrs) { { label: 'Test Kitchen', start_date: nil, end_date: nil } }

    it 'does not create new menu item' do
      expect { subject }.to_not change(Menu, :count)
    end

    it 'has errors' do
      subject

      gql_response = JSON.parse(response.body)
      expect(gql_response['errors']).to be_present
    end
  end

  describe 'end date is before start date' do
    let(:query_attrs) { { label: 'Test Kitchen', start_date: '2024-05-01', end_date: '2024-04-30' } }

    it 'does not create new menu item' do
      expect { subject }.to_not change(Menu, :count)
    end

    it 'has errors' do
      subject

      gql_response = JSON.parse(response.body)
      expect(gql_response['errors']).to be_present
    end
  end
end
