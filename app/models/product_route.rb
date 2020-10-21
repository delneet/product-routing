class ProductRoute
  def initialize(product_reference)
    @product_reference = product_reference
  end

  def destination
    # TODO: evaluate routes
  end

  def route_definitions
    criteria_definitions.flat_map { |criteria_definition|
      criteria_definition.route_definitions.select { |route_definition|
        route_definition.matches_product?(product)
      }
    }.uniq
  end

  private

  attr_reader :product_reference

  delegate :category, :price, to: :product

  def product
    @product ||= Product.find_by(reference: product_reference)
  end

  def criteria_definitions
    @criteria_definitions ||=
      CriteriaDefinition
        .with_reference(product_reference)
        .or(CriteriaDefinition.with_category(category))
        .merge(CriteriaDefinition.with_max_price(price))
  end
end
