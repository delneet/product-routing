require "rails_helper"

RSpec.describe RouteDefinition do
  it_behaves_like "a definition output format" do
    let(:definition_with_attributes) {
      described_class.new(%W[REF_1 REF_2], %W[CAT_1 CAT_2], 100.00, "DEST_1")
    }

    let(:definition_without_attributes) {
      described_class.new(nil, nil, nil, "DEST_1")
    }
  end

  describe "#matches_product?" do
    let(:product) {
      Product.new(
        name: "Some product",
        reference: "REF_1",
        category: "CAT_1",
        price: 100
      )
    }

    context "when it includes the product reference" do
      subject(:route_definition) { described_class.new("REF_1", nil, nil, "DEST_1") }

      it "returns true" do
        actual = route_definition.matches_product?(product)

        expect(actual).to eql true
      end
    end

    context "when it includes the product category" do
      subject(:route_definition) { described_class.new(nil, "CAT_1", nil, "DEST_1") }

      it "returns true" do
        actual = route_definition.matches_product?(product)

        expect(actual).to eql true
      end
    end

    context "when it includes just the product price" do
      subject(:route_definition) { described_class.new(nil, nil, 100, "DEST_1") }

      it "returns false" do
        actual = route_definition.matches_product?(product)

        expect(actual).to eql false
      end
    end

    context "when does not include any product value" do
      subject(:route_definition) { described_class.new(nil, nil, nil, "DEST_1") }

      it "returns false" do
        actual = route_definition.matches_product?(product)

        expect(actual).to eql false
      end
    end
  end

  describe "#weight" do
    context "when it has 0 product values" do
      subject(:route_definition) { described_class.new(nil, nil, nil, "DEST_1") }

      it "returns 0" do
        actual = route_definition.weight

        expect(actual).to eql 0
      end
    end

    context "when it has 1 product value" do
      subject(:route_definition) { described_class.new("REF_1", nil, nil, "DEST_1") }

      it "returns 1" do
        actual = route_definition.weight

        expect(actual).to eql 1
      end
    end

    context "when it has 2 product values" do
      subject(:route_definition) { described_class.new("REF_1", "CAT_1", nil, "DEST_1") }

      it "returns 1" do
        actual = route_definition.weight

        expect(actual).to eql 2
      end
    end

    context "when it has 3 product values" do
      subject(:route_definition) { described_class.new("REF_1", "CAT_1", 100, "DEST_1") }

      it "returns 1" do
        actual = route_definition.weight

        expect(actual).to eql 3
      end
    end
  end
end
