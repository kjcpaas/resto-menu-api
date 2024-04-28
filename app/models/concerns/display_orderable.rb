# frozen_string_literal: true

# DisplayOrderable manages logic for display ordering
module DisplayOrderable
  extend ActiveSupport::Concern

  class_methods do
    def validate_display_order_for(context)
      validates :display_order, numericality: { integer: true, greater_than_or_equal_to: 0 }, uniqueness: {
        # Each section in the menu must have different display_order
        scope: context
      }
    end
  end
end
