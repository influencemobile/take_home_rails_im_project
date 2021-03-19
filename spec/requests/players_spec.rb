# spec/requests/players_spec.rb
require 'rails_helper'

RSpec.describe 'Players API', type: :request do 
  # initialize test data
  let!(:players) { create_list(:player, 10) }
  let(:player_id) { players.first.id }

  # Test suite for GET /players
  describe 'GET /api/v1/players' do
    # make HTTP get request before each example
    before { get '/api/v1/players' }

    it 'returns players' do 
      # Note 'json' is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end 

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /players/:id
  describe 'GET /api/v1/players/:id' do
    before { get "/api/v1/players/#{player_id}" }
    
    context 'when the record exists' do 
      it 'returns the player' do 
        expect(json).not_to be_empty 
        expect(json['id']).to eq(player_id)
      end

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:player_id) { 100 }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do 
        # byebug
        # "{\"message\":\"Couldn't find Player with 'id'=100\"}"
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  # Test suite for POST /api/v1/players
  describe 'POST /api/v1/players' do
    # valid payload
    let(:valid_attributes) { { age: '1958-07-28', first_name: 'Taco Lu', gender: 'Male', username: 'tacoring@gmail.com'} }

    context 'when the request is valid' do 
      before { post '/api/v1/players', params: valid_attributes }

      it 'created a player' do 
        expect(json['age']).to eq('1958-07-28')
        expect(json['first_name']).to eq('Taco Lu')
        expect(json['gender']).to eq('Male')
        expect(json['username']).to eq('tacoring@gmail.com')
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do 
      before { post '/api/v1/players', params: { age: '1958-07-28' } }
      # :age, :first_name, :gender, :username

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do 
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for PUT /api/v1/players/:id
  describe 'PUT /api/v1/players/:id' do 
    let(:valid_attributes) { { age: '1958-07-28' } }

    context 'when the record exists' do 
      before { put "/api/v1/players/#{player_id}", params: valid_attributes }

      it 'updates the record' do
        # expect(response.body).to be_empty
        expect(json['age']).to eq('1958-07-28')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /api/v1/players/:id
  describe 'DELETE /api/v1/players/:id' do
    before { delete "/api/v1/players/#{player_id}" }

    it 'returns status code 204' do 
      expect(response).to have_http_status(204)
    end
  end
end