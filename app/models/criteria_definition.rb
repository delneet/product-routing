class CriteriaDefinition < ApplicationRecord
  include RouteDefinitionOutput

  validates :destination, presence: true
  validates :max_product_price, numericality: true, allow_nil: true

  scope :with_reference, ->(reference) { where("product_references @> ?", "{#{reference}}") }
  scope :with_category, ->(category) { where("product_categories @> ?", "{#{category}}") }
  scope :with_max_price, ->(price) { where("max_product_price <= ?", price) }

  def route_definitions
    products = (product_references.presence || [nil])
    categories = (product_categories.presence || [nil])
    max_price = [max_product_price]

    permutations = products.product(categories, max_price)
    permutations.map { |attributes| RouteDefinition.new(*attributes, destination) }
  end
end
