require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_uniqueness_of(:reference)}
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:category)}
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:category)}
  it { is_expected.to validate_numericality_of(:price)}
end
