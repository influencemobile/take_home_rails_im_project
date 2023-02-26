class Offer < ActiveRecord::Base
  validates :description, presence: true
  has_many :offers_targets
end
