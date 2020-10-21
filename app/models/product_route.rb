class ProductRoute
  attr_reader :product_reference

  def initialize(product_reference)
    @product_reference = product_reference
  end

  def destination
    return if highest_weight_destinations.blank?

    highest_weight_destinations.sample.destination
  end

  def route_definitions
    return [] unless criteria_definitions

    criteria_definitions.flat_map { |criteria_definition|
      criteria_definition.route_definitions.select { |route_definition|
        route_definition.matches_product?(product)
      }
    }.uniq
  end

  private

  delegate :category, :price, to: :product

  def product
    @product ||= Product.find_by(reference: product_reference)
  end

  def criteria_definitions
    return unless product

    @criteria_definitions ||=
      CriteriaDefinition
        .with_reference(product_reference)
        .or(CriteriaDefinition.with_category(category))
        .merge(CriteriaDefinition.with_max_price(price))
  end

  def highest_weight_destinations
    return [] if weighted_destinations.blank?

    weighted_destinations.max_by { |k, v| k }[1]
  end

  def weighted_destinations
    return {} if route_definitions.blank?

    route_definitions.group_by(&:weight)
  end
end
