require 'rails_helper'

RSpec.describe Offer, type: :model do
  it 'is valid with a description' do
    offer = Offer.new(description: '3 million dollars a month')
    expect(offer).to be_valid
  end

  it 'is not valid without a description' do
    offer = Offer.new(description: nil)
    expect(offer).to_not be_valid
  end
end
