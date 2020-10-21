module RouteDefinitionOutput
  def to_s
    refs = output_array_string(product_references)
    cats = output_array_string(product_categories)
    price = max_product_price&.round(2) || "_"

    "[ %s, %s, %s ] -> %s" % [refs, cats, price, destination]
  end

  private

  def output_array_string(attribute)
    attribute.present? ? "[#{attribute.join(", ")}]" : "_"
  end
end
