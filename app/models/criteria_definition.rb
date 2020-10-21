class CriteriaDefinition < ApplicationRecord
  validates :destination, presence: true
  validates :max_product_price, numericality: true, allow_nil: true
end
