require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'is not valid without a first name' do
    user = User.new(first_name: nil, username: 'testplayer', age: '1999-01-01', gender: 'male')
    expect(user).to_not be_valid
  end
end
