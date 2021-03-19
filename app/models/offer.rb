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
  has_many :offers_targets, dependent: :destroy

  # validations
  validates_presence_of :description
end
