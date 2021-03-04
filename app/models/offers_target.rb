# == Schema Information
#
# Table name: offers_targets
#
#  id       :bigint           not null, primary key
#  age      :integer
#  gender   :string
#  offer_id :integer
#
class OffersTarget < ActiveRecord::Base
  belongs_to :offer
end
