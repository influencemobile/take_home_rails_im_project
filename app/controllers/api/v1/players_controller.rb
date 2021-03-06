# 
class Api::V1::PlayersController < ApplicationController

  def index
    logger.info '[Players][controller][index]'
    render json: Player.all.order(created_at: :asc)
  end

  def update
    logger.info "[Players][controller][update] #{params[:id]}"
    logger.info params
    player = Player.find(params[:id])
    player.update_attributes(player_params)
    render json: player
  end

  private
  def player_params
    params.require(:player).permit(:id, :first_name, :age, :gender)
  end
end
