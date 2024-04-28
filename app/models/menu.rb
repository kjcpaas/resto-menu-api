# frozen_string_literal: true

# Menu represents a restaurant menu
class Menu < ApplicationRecord
  include StringIdentifiable

  # Associations
  has_many :menu_sections, -> { order(:display_order) }, dependent: :destroy

  # Assumption is this is the menu title so this must not be blank
  validates :label, presence: true

  # Assumption is that a state is assigned upon creation, depedepending on restaurant workflow
  # For our purposes, this is just `draft` and `active`, where:
  # - draft: menu is under development, hence not to be presented to customers
  # - active: menu can be presented to customers
  validates :state, presence: true, inclusion: { in: %w[active draft] }

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :end_date_not_before_start_date

  private

  def end_date_not_before_start_date
    return unless end_date.present?
    return unless start_date.present?
    return unless end_date < start_date

    errors.add(:end_date, "can't be before start_date")
  end
end
