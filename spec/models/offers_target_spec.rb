require 'rails_helper'

RSpec.describe OffersTarget, type: :model do 

  # Association test
  it { should belong_to(:offer) }

  # Validation tests
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:gender) }

end
