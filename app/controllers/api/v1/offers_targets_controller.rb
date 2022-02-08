# 
class Api::V1::OffersTargetsController < ApplicationController
  before_action :set_offer
  before_action :set_offer_target, only: [:show, :update, :destroy]

  # GET /api/v1/offers/:offer_id/offers_targets
  def index
    # logger.info '[OffersTargets][controller][index]'
    # render json: OffersTarget.all
    json_response(@offer.offers_targets)
  end

  # GET /api/v1/offers/:offer_id/offers_targets/:id
  def show 
    json_response(@offer_target)
  end

  # POST /api/v1/offers/:offer_id/offers_targets
  def create 
    @offer.offers_targets.create!(offers_target_params)
    json_response(@offer, :created)
  end

  # PUT /api/v1/offers/:offer_id/offers_targets/:id
  def update
    @offer_target.update(offers_target_params)
    head :no_content
  end

  # DELETE /api/v1/offers/:offer_id/offers_targets/:id
  def destroy 
    @offer_target.destroy 
    head :no_content
  end

  private 
  
  def offers_target_params
    params.permit(:age, :gender, :offer_id)
  end

  def set_offer 
    @offer = Offer.find(params[:offer_id])
  end

  def set_offer_target
    @offer_target = @offer.offers_targets.find_by!(id: params[:id]) if @offer
  end

end
