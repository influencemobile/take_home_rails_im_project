# 
class Api::V1::OffersController < ApplicationController
  before_action :set_offer, only: [:show, :update, :destroy]
  
  # GET /api/v1/offers
  def index
    # logger.info '[Offers][controller][index]'
    # render json: Offer.all.order(created_at: :asc)
    # Offer.includes(:offers_targets)
    # @offers = Offer.all 
    # @offers = Offer.all.includes(:offers_targets)
    @offers = Offer.all.joins(:offers_targets).select("offers.*, offers_targets.*")
    # @offers = Offer.all.includes(:offers_targets).select("offers.*, offers_targets.*")
    json_response(@offers)
  end

  # GET /api/v1/offers/:id
  def show 
    json_response(@offer)
  end

  # POST /api/v1/offers
  def create
    @offer = Offer.create!(offer_params)
    json_response(@offer, :created) 
  end

  # PUT /api/v1/offers/:id 
  def update
    @offer.update(offer_params)
    head :no_content
  end

  # DELETE /api/v1/offers/:id
  def destroy 
    @offer.destroy
    head :no_content
  end

  private 

  def offer_params
    params.permit(:description)
  end

  def set_offer 
    @offer = Offer.find(params[:id])
    logger.info '[Offers][controller][set_offer]'
    logger.info @offer
  end

end
