require 'rails_helper'

RSpec.describe OffersTarget, type: :model do
  before do
    @offer = Offer.create!(description: '30 thousand dollars for 7 weeks')
  end

  it 'is invalid without an offer_id' do
    offer_target = OffersTarget.new(age: '1999-01-01', offer_id: nil, gender: 'Male')
    expect(offer_target).to_not be_valid
  end

  it 'is valid with an offer_id, age and gender' do
    offer_target = OffersTarget.new(age: '1999-01-01', offer_id: @offer.id, gender: 'Male')
    expect(offer_target).to be_valid
  end

  it 'is invalid without an age' do
    offer_target = OffersTarget.new(age: nil, offer_id: @offer.id, gender: 'Male')
    expect(offer_target).to_not be_valid
  end

  it 'is invalid without a gender' do
    offer_target = OffersTarget.new(age: '1999-01-01', offer_id: @offer.id, gender: nil)
    expect(offer_target).to_not be_valid
  end 
end
