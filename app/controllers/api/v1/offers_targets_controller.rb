# 
class Api::V1::OffersTargetsController < ApplicationController
  
  def index
    logger.info '[OffersTargets][controller][index]'
    render json: OffersTarget.all
  end

end
