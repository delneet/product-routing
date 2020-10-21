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

  describe "#to_s" do
    it "outputs the criteria definition in a predefined format" do
      definition =
        described_class.new(
          product_references: %W[REF_1 REF_2],
          product_categories: %W[CAT_1 CAT_2],
          max_product_price: 100.00,
          destination: "DEST_1"
        )

      expected = "[ [REF_1, REF_2], [CAT_1, CAT_2], 100.0 ] -> DEST_1"

      expect(definition.to_s).to eql expected
    end

    context "when attributes are empty" do
      it "outputs the criteria definition in a predefined format" do
        definition =
          described_class.new(
            product_references: [],
            product_categories: [],
            max_product_price: nil,
            destination: "DEST_1"
          )

        expected = "[ _, _, _ ] -> DEST_1"

        expect(definition.to_s).to eql expected
      end
    end
  end
end
