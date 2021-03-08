# 
class Api::V1::OffersController < ApplicationController
  
  def index
    logger.info '[Offers][controller][index]'
    render json: Offer.all.order(created_at: :asc)
  end

end
