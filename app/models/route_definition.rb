class RouteDefinition
  include RouteDefinitionOutput

  attr_reader :product_references, :product_categories, :max_product_price, :destination

  def initialize(product_references, product_categories, max_product_price, destination)
    @product_references = Array(product_references)
    @product_categories = Array(product_categories)
    @max_product_price = max_product_price
    @destination = destination
  end

  def matches_product?(product)
    product.reference.in?(product_references) ||
      product.category.in?(product_categories) ||
      product.price.to_d <= max_product_price.to_d
  end

  def weight
    [
      product_references.present?,
      product_categories.present?,
      max_product_price.present?
    ].count(true)
  end
end
