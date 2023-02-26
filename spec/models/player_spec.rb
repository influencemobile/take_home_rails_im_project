require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'is not valid without a first name' do
    user = Player.new(first_name: nil, username: 'testplayer', age: '1999-01-01', gender: 'male')
    expect(user).to_not be_valid
  end

  it 'is not valid without a user name' do
    user = Player.new(first_name: 'test name', username: nil, age: '1999-01-01', gender: 'male')
    expect(user).to_not be_valid
  end

  it 'is not valid without an age' do
    user = Player.new(first_name: 'test name', username: 'testusername', age: nil, gender: 'male')
    expect(user).to_not be_valid
  end

  it 'is not valid without a gender' do
    user = Player.new(first_name: 'test name', username: 'testusername', age: '1999-01-01', gender: nil)
    expect(user).to_not be_valid
  end

  it 'is valid with a first name,username, age and gender' do
    user = Player.new(first_name: 'test name', username: 'testusername', age: '1999-01-01', gender: 'female')
    expect(user).to be_valid
  end
end
