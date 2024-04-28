# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateMenu, type: :request do
  def read_graphql_mutation_fixture_file(filename)
    File.read(File.join('spec', 'fixtures', 'graphql', 'mutations', filename))
  end

  let(:query_template) { ERB.new(read_graphql_mutation_fixture_file('update_menu.gql.erb')) }
  let(:query) do
    query_template.result_with_hash({
      identifier: nil,
      label: nil,
      start_date: nil,
      end_date: nil,
      state: nil
    }.merge(query_attrs))
  end

  subject do
    post '/graphql', params: { query: }
  end

  describe 'updating existing menu' do
    let!(:menu) { create :menu }
    let(:query_attrs) { { identifier: menu.identifier, label: 'New Label' } }

    it 'updates a Menu record' do
      expect { subject }.to change {
        menu.reload
        menu.label
      }.to query_attrs[:label]
    end

    it 'updates the record with the specified identifier' do
      subject

      gql_response = JSON.parse(response.body)
      expect(gql_response.dig('data', 'updateMenu', 'menu', 'identifier')).to eq menu.identifier
    end
  end

  describe 'updating non-existent Menu' do
    let!(:menu) { create :menu }
    let(:query_attrs) { { identifier: 'idontexist', label: 'foo' } }

    it 'does not change any Menu record' do
      expect { subject }.to_not(change do
        menu.reload
        menu.label
      end)
    end

    it 'has errors' do
      subject

      gql_response = JSON.parse(response.body)
      expect(gql_response['errors']).to be_present
    end
  end
end
