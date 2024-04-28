# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  def read_graphql_fixture_file(filename)
    File.read(File.join('spec', 'fixtures', 'graphql', filename))
  end

  before do
    # Seed DB
    load Rails.root.join('db', 'seeds.rb')
  end

  describe 'menus' do
    let(:query) { read_graphql_fixture_file('menus_query.gql') }
    let(:expected_json) { JSON.parse(read_graphql_fixture_file('menus_query_response.json')) }

    it 'fetches all menus with the requested information' do
      post '/graphql', params: { query: }
      gql_response = JSON.parse(response.body)

      expect(gql_response).to eq expected_json
    end
  end
end
