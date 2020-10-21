RSpec.shared_examples "a definition output format" do
  it "outputs the criteria definition in a predefined format" do
    expected = "[ [REF_1, REF_2], [CAT_1, CAT_2], 100.0 ] -> DEST_1"

    expect(definition_with_attributes.to_s).to eql expected
  end

  context "when attributes are empty" do
    it "outputs the criteria definition in a predefined format" do
      expected = "[ _, _, _ ] -> DEST_1"

      expect(definition_without_attributes.to_s).to eql expected
    end
  end
end
