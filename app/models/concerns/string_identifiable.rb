# frozen_string_literal: true

# StringIdentifiable contains helper functions formodels with string identifier
module StringIdentifiable
  extend ActiveSupport::Concern

  included do
    self.primary_key = :identifier

    validates :identifier, presence: true

    after_initialize do |record|
      record.identifier = SecureRandom.uuid unless record.persisted?
    end
  end
end
