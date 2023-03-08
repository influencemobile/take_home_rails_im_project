class Offer < ApplicationRecord
  validates :description, presence: true
  has_many :offers_targets
end
