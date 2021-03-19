# spec/requests/offers_targets_spec.rb
require 'rails_helper'
require 'faker'

RSpec.describe 'OffersTargets API' do 
  # Initialize the test data
  let!(:offer) { create(:offer) }
  let!(:offers_targets) { create_list(:offers_target, 20, offer_id: offer.id) }
  let(:offer_id) { offer.id }
  let(:id) { offers_targets.first.id }

  # Test suite for GET /api/v1/offers/:offer_id/offers_targets
  describe 'GET /api/v1/offers/:offer_id/offers_targets' do 
    before { get "/api/v1/offers/#{offer_id}/offers_targets"}

    # offer exist 
    context 'when offer exists' do 
      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end
      
      it 'return all offers offers_targets' do 
        expect(json.size).to eq(20)
      end
    end

    context 'when offer does not exist' do 
      let(:offer_id) { 0 }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find Offer/)
      end
    end
  end 

  # Test suite for GET /api/v1/offers/:offer_id/offers_targets/:id
  describe 'GET /api/v1/offers/:offer_id/offers_targets/:id' do 
    before { get "/api/v1/offers/#{offer_id}/offers_targets/#{id}"}

    # record exists
    context 'when offer offers_target exists' do 
      it 'return status code 200' do 
        expect(response).to have_http_status(200)
      end

      it 'return the offers_target' do
        expect(json['id']).to eq(id)
      end
    end   
  
    # record does not exist
    context 'when offers target does not exist' do 
      let(:id) { 0 }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404  )
      end

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find OffersTarget/)
      end
    end
  end 

  # Test suite for POST /api/v1/offers/:offer_id/offers_targets
  describe 'POST /api/v1/offers/:offer_id/offers_targets' do 
    let(:valid_attributes) { { age: '40', gender: 'Female' } }

    context 'when request attributes are valid' do 
      before { post "/api/v1/offers/#{offer_id}/offers_targets", params: valid_attributes }

      it 'returns status code 201' do 
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do 
      before { post "/api/v1/offers/#{offer_id}/offers_targets", params: {} }

      it 'return status code 422' do 
        expect(response).to have_http_status(422)
      end

      it 'return a failure message' do 
        expect(response.body).to match(/Validation failed: Age can't be blank, Gender can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/offers/:offer_id/offers_targets/:id
  describe 'PUT /api/v1/offers/:offers_id/offers_targets/:id' do 
    let(:valid_attributes) { { age: '40', gender: 'Female' } }

    before { put "/api/v1/offers/#{offer_id}/offers_targets/#{id}", params: valid_attributes }

    context 'when offers_target exists' do 
      it 'returns status code 204' do 
        expect(response).to have_http_status(204)
      end

      it 'updates the offers target' do 
        updated_offers_target = OffersTarget.find(id)
        expect(updated_offers_target.age).to match(40)
        expect(updated_offers_target.gender).to match(/Female/)
      end
    end

    context 'when the offers_target does not exist' do 
      let(:id) { 0 }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find OffersTarget/)
      end
    end
  end

  # Test suite for DELETE /api/v1/offers/:offer_id/offers_targets/:id
  describe 'DELETE /api/v1/offers/:offer_id/offers_targets/:id' do 
    before { delete "/api/v1/offers/#{offer_id}/offers_targets/#{id}" }

    it 'returns status code 204' do 
      expect(response).to have_http_status(204)
    end
  end

end