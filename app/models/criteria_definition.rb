class CriteriaDefinition < ApplicationRecord
  include RouteDefinitionOutput

  validates :destination, presence: true
  validates :max_product_price, numericality: true, allow_nil: true

  scope :with_reference, ->(reference) { where("product_references @> ?", "{#{reference}}") }
  scope :with_category, ->(category) { where("product_categories @> ?", "{#{category}}") }
  scope :with_max_price, ->(price) { where("COALESCE(max_product_price, 0) <= ?", price) if price }

  before_save :reject_blanks

  def route_definitions
    products = (product_references.presence || [nil])
    categories = (product_categories.presence || [nil])
    max_price = [max_product_price]

    permutations = products.product(categories, max_price)
    permutations.map { |attributes| RouteDefinition.new(*attributes, destination) }
  end

  private

  def reject_blanks
    product_references&.reject!(&:blank?) if product_references_changed?
    product_categories&.reject!(&:blank?) if product_categories_changed?
  end
end
