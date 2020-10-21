require "rails_helper"

RSpec.describe CriteriaDefinition, type: :model do
  RSpec.shared_examples_for "an array" do |attribute|
    it "behaves like an array" do
      expect(subject.public_send(attribute)).to respond_to(:each)
    end
  end

  it { is_expected.to validate_presence_of(:destination) }
  it { is_expected.to validate_numericality_of(:max_product_price).allow_nil }

  describe "#product_references" do
    it_behaves_like "an array", :product_references
  end

  describe "#product_categories" do
    it_behaves_like "an array", :product_categories
  end
end
