# == Schema Information
#
# Table name: offers
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Offer < ActiveRecord::Base
  has_many :Offers_targets
end
