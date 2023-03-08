require 'date'

class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
    @age = ((Date.today - @player.age) / 365.25).to_i
    @offers_targets = OffersTarget.select { |idx| idx.age == @age && idx.gender == @player.gender }
  end
end
