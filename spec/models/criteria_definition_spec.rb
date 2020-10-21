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

  it_behaves_like "a definition output format" do
    let(:definition_with_attributes) {
      described_class.new(
        product_references: %W[REF_1 REF_2],
        product_categories: %W[CAT_1 CAT_2],
        max_product_price: 100.00,
        destination: "DEST_1"
      )
    }

    let(:definition_without_attributes) {
      described_class.new(
        product_references: nil,
        product_categories: nil,
        max_product_price: nil,
        destination: "DEST_1"
      )
    }
  end

  describe "#route_definitions" do
    subject(:definition) {
      described_class.new(
        product_references: %W[REF_1 REF_2],
        product_categories: %W[CAT_1 CAT_2],
        max_product_price: 100.00,
        destination: "DEST_1"
      )
    }

    it "returns route definitions for the permutations of criteria" do
      expect(RouteDefinition).to receive(:new).exactly(4).times
      expect(definition.route_definitions.size).to eql 4
    end
  end
end
