# 
class Api::V1::PlayersController < ApplicationController

  def index
    logger.info '[Players][controller][index]'
    render json: Player.all.order(created_at: :asc)
  end

  def update
    logger.info "[Players][controller][update] #{params[:id]}"

    player = Player.find(params[:id])
    # player.update_attributes(player_params)
    
    # player.update!(first_name: Faker::Name.unique.name, gender: params[:id].to_i % 2 == 0 ? 'Female' : 'Male', age: Faker::Date.birthday(min_age: 18, max_age: 65) )
    # render json: player
    begin 
      player.update!(first_name: Faker::Name.unique.name, gender: params[:id].to_i % 2 == 0 ? 'Female' : 'Male', age: Faker::Date.birthday(min_age: 18, max_age: 65) )
      render json: player
    rescue
      render 'error/406', status: 406
    end
  end

  private
  def player_params
    params.require(:player).permit(:id, :first_name, :age, :gender)
  end
end
