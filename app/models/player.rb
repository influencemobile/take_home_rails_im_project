# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  age        :date
#  first_name :string
#  gender     :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Player < ActiveRecord::Base
end
