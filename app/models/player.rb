class Player < ActiveRecord::Base
    validates :username, presence: true
    validates :first_name, presence: true
    validates :gender, presence: true
    validates :age, presence: true

    has_many :offers
    has_many :offers_targets
end
