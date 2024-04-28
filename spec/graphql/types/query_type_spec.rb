# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  def read_graphql_query_fixture_file(filename)
    File.read(File.join('spec', 'fixtures', 'graphql', 'queries', filename))
  end

  before do
    # Seed DB
    load Rails.root.join('db', 'seeds.rb')
  end

  describe 'model_queries' do
    # TODO: Add more models if there is time
    # %w[
    #   menus menu_sections sections section_items items
    #   item_modifier_groups modifier_groups modifiers].each do |model|
    %w[menus menu_sections].each do |model|
      it "fetches all #{model} with the requested information" do
        query = read_graphql_query_fixture_file("#{model}.gql")
        expected_json =  JSON.parse(read_graphql_query_fixture_file("#{model}_response.json"))

        post '/graphql', params: { query: }
        gql_response = JSON.parse(response.body)

        expect(gql_response).to eq expected_json
      end
    end
  end
end
