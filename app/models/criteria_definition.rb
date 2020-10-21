class CriteriaDefinition < ApplicationRecord
  validates :destination, presence: true
  validates :max_product_price, numericality: true, allow_nil: true

  def to_s
    references = output_array_string(product_references)
    categories = output_array_string(product_categories)
    price = max_product_price&.round(2) || "_"

    "[ %s, %s, %s ] -> %s" % [references, categories, price, destination]
  end

  private

  def output_array_string(attribute)
    attribute.present? ? "[#{attribute.join(", ")}]" : "_"
  end
end
