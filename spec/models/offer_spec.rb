require 'rails_helper'

RSpec.describe Offer, type: :model do 

  # Association test
  it { should have_many(:offers_targets).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:description) }
end