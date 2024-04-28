# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::DeleteMenu, type: :request do
  def read_graphql_mutation_fixture_file(filename)
    File.read(File.join('spec', 'fixtures', 'graphql', 'mutations', filename))
  end

  let(:query_template) { ERB.new(read_graphql_mutation_fixture_file('delete_menu.gql.erb')) }
  let(:query) do
    query_template.result_with_hash(query_attrs)
  end

  subject do
    post '/graphql', params: { query: }
  end

  describe 'deleting existing menu' do
    let!(:menu) { create :menu }
    let(:query_attrs) { { identifier: menu.identifier } }

    it 'deletes a Menu record' do
      expect { subject }.to change(Menu, :count).by(-1)
    end

    it 'deletes the record with the specified identifier' do
      subject

      gql_response = JSON.parse(response.body)
      expect(gql_response.dig('data', 'deleteMenu', 'menu', 'identifier')).to eq menu.identifier
    end
  end

  describe 'deleting non-existent Menu' do
    let!(:menu) { create :menu }
    let(:query_attrs) { { identifier: 'idontexist' } }

    it 'does not delete any Menu record' do
      expect { subject }.to_not change(Menu, :count)
    end

    it 'has errors' do
      subject

      gql_response = JSON.parse(response.body)
      expect(gql_response['errors']).to be_present
    end
  end
end
