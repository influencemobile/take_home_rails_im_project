class OffersTargetsController < ApplicationController
    def index
        @offers_targets = OffersTarget.includes(:offer)
        @offer = Offer.all
    end
end
