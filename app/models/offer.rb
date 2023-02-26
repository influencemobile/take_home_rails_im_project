class Offer < ActiveRecord
  validates :description, presence: true
  has_many :offers_targets
end
