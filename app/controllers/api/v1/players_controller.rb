# 
class Api::V1::PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]
  
  # GET /api/v1/players
  def index
    logger.info '[Players][controller][index]'
    # render json: Player.all.order(created_at: :asc)
    @players = Player.all
    logger.info '[Players][controller][index]'
    # byebug
    json_response(@players)
  end

  # POST /api/v1/players
  def create 
    @player = Player.create!(player_params)
    # byebug
    json_response(@player, :created)
  end

  # GET /api/v1/players/:id
  def show 
    json_response(@player)
  end

  # PUT /api/v1/players/:id
  def update
    logger.info "[Players][controller][update] #{params[:id]}"

    # player = Player.find(params[:id])
    # player.update_attributes(player_params)
    
    # player.update!(first_name: Faker::Name.unique.name, gender: params[:id].to_i % 2 == 0 ? 'Female' : 'Male', age: Faker::Date.birthday(min_age: 18, max_age: 65) )
    # render json: player
    # begin 
    # @player.update(first_name: Faker::Name.unique.name, gender: params[:id].to_i % 2 == 0 ? 'Female' : 'Male', age: Faker::Date.birthday(min_age: 18, max_age: 65) )
    @player.update!(player_params)
    # head :no_content
    p @player
    json_response(@player)
      #   render json: player
    # rescue
    #   render 'error/406', status: 406
    # end

  end

  # DELETE /api/v1/players/:id 
  def destroy 
    @player.destroy
    head :no_content
  end

  private
  
  def player_params
    params.permit(:id, :first_name, :age, :gender, :username, :player)
  end

  def set_player
    @player = Player.find(params[:id])
  end

end
