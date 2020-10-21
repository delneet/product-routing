require "rails_helper"

RSpec.describe ProductRoute, type: :model do
  describe "#destination" do
    subject(:product_route) { described_class.new("REF_1") }

    before { allow(product_route).to receive(:route_definitions) { route_definitions } }

    let(:route_definitions) {
      [
        instance_double("RouteDefinition", destination: "DEST_1", weight: 1),
        instance_double("RouteDefinition", destination: "DEST_2", weight: 2),
        instance_double("RouteDefinition", destination: "DEST_3", weight: 3),
        instance_double("RouteDefinition", destination: "DEST_4", weight: 3)
      ]
    }

    it "returns the destination of the route definition with the highest weight" do
      expect(product_route.destination).to eql("DEST_3").or eql("DEST_4")
    end

    context "without matching criteria definitions" do
      before { allow(product_route).to receive(:route_definitions) }

      it "returns nil" do
        expect(product_route.destination).to be_nil
      end
    end
  end

  describe "#route_definitions" do
    context "with a single criteria definition" do
      before do
        create(:criteria_definition,
          product_references: %W[REF_1 REF_8],
          product_categories: %W[CAT_1 CAT_3],
          max_product_price: 100,
          destination: "DEST_1")
      end

      let!(:product) {
        create(:product,
          name: "Product 1",
          reference: "REF_1",
          category: "CAT_1",
          price: 100)
      }

      subject(:product_route) { described_class.new(product.reference) }

      it "returns route definitions matching criteria definitions for product" do
        expected = [
          "[ [REF_1], [CAT_1], 100.0 ] -> DEST_1",
          "[ [REF_1], [CAT_3], 100.0 ] -> DEST_1",
          "[ [REF_8], [CAT_1], 100.0 ] -> DEST_1"
        ]

        actual = product_route.route_definitions.map(&:to_s)

        expect(actual).to match_array(expected)
      end
    end

    context "with multiple overlapping criteria definitions" do
      before do
        create(:criteria_definition,
          product_references: %W[REF_1 REF_8], # Match
          product_categories: %W[CAT_9],
          max_product_price: nil,
          destination: "DEST_1")
        create(:criteria_definition,
          product_references: %W[REF_1 REF_10], # Match
          product_categories: %W[CAT_3],
          max_product_price: 100,
          destination: "DEST_2")
        create(:criteria_definition,
          product_references: %W[REF_1 REF_8],
          product_categories: %W[CAT_9],
          max_product_price: 150, # No match
          destination: "DEST_3")
        create(:criteria_definition, # No match
          product_references: %W[REF_2 REF_8],
          product_categories: %W[CAT_9],
          max_product_price: 50,
          destination: "DEST_4")
        create(:criteria_definition, # No match
          product_references: %W[REF_7 REF_8],
          product_categories: %W[CAT_9],
          max_product_price: nil,
          destination: "DEST_5")
        create(:criteria_definition,
          product_references: nil,
          product_categories: %W[CAT_1], # Match
          max_product_price: nil,
          destination: "DEST_6")
      end

      let!(:product) {
        create(:product,
          name: "Product 1",
          reference: "REF_1",
          category: "CAT_1",
          price: 100)
      }

      subject(:product_route) { described_class.new(product.reference) }

      it "returns route definitions matching criteria definitions for product" do
        expected = [
          "[ [REF_1], [CAT_9], _ ] -> DEST_1",
          "[ [REF_1], [CAT_3], 100.0 ] -> DEST_2",
          "[ _, [CAT_1], _ ] -> DEST_6"
        ]

        actual = product_route.route_definitions.map(&:to_s)

        expect(actual).to match_array(expected)
      end
    end
  end
end
