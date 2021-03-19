# spec/requests/offers_spec.rb
require 'rails_helper'

RSpec.describe 'Offers API', type: :request do 
  # initialize test data
  let!(:offers) { create_list(:offer, 10) }
  let(:offer_id) { offers.first.id }
  let(:offers_targets) { create_list(:offers_target, 100, offer_id: offer_id) }

  # let!(:offer) { create(:offer) }
  # let!(:offers_targets) { create_list(:offers_target, 20, offer_id: offer.id) }
  # let(:offer_id) { offer.id }
  # let(:id) { offers_targets.first.id }

  # Test suite for GET /api/v1/offers
  describe 'GET /api/v1/offers' do 
    # make HTTP get request before each example
    before { get '/api/v1/offers' }

    it 'return offers' do 
      # Note 'json' is a custom helper to parse JSON responses
      # expect(json).to match(offers_targets)
      # expect(json).to match(offers)
      # expect(json).not_to be_empty 
      # expect(json.size).to eq(10)
    end

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/offers/:id
  describe 'GET /api/v1/offers/:id' do 
    before { get "/api/v1/offers/#{offer_id}" }

    # record exists
    context 'when the record exists' do 
      it 'returns the offer' do 
        expect(json).not_to be_empty
        expect(json['id']).to eq(offer_id)
      end

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end
    end

    # record does not exist
    context 'when the record does not exist' do 
      let(:offer_id) { 100 }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find Offer/)
      end
    end
  end

  # Test suite for POST /api/v1/offers
  describe 'POST /api/v1/offers/' do 
    let(:valid_attributes) { { description: 'hey it\'s a big deal, check out!' } }

    # request is valid
    context 'when the request is valid' do 
      before { post '/api/v1/offers', params: valid_attributes}

      it 'creates a offer' do 
        expect(json['description']).to eq('hey it\'s a big deal, check out!')
      end

      it 'returns status code 201' do 
        expect(response).to have_http_status(201)
      end
    end

    # request is invalid
    context 'when the request is invalid' do 
      before { post '/api/v1/offers', params: {} }

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do 
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/offers/:id
  describe 'PUT /api/v1/offers/:id' do 
    let(:valid_attributes) { { description: 'Nice offer, don\'t be the last one' } }
  
    context 'when the record exists' do 
      before { put "/api/v1/offers/#{offer_id}", params: valid_attributes }

      it 'updates the record' do 
        expect(response.body).to be_empty 
      end

      it 'returns status code 204' do 
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1
  describe 'DELETE /api/v1/offers/:id' do 
    before { delete "/api/v1/offers/#{offer_id}" }

    it 'returns status code 204' do 
      expect(response).to have_http_status(204)
    end

  end
end