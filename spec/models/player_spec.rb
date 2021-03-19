require 'rails_helper'

RSpec.describe Player, type: :model do 

  # Association test
  # None

  # Validation tests
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:username) }
end
