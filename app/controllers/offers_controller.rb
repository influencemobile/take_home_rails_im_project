class OffersController < ApplicationController
 # before_action :set_offer only: %i[show update destroy]

  def index
    @offers = Offer.includes(:offers_targets)
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def destroy
    @offer.destroy

    respond_to do |format|
        format.html { redirect_to offers_url, notice: 'Offer successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
