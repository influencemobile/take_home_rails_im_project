class OffersTarget < ActiveRecord::Base
  belongs_to :offer
  validates :age, presence: true
  validates :gender, presence: true
  validates :offer_id, presence: true
end
