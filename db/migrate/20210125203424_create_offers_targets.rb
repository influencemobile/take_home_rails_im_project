class CreateOffersTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :offers_targets do |t|
      t.integer  :age
      t.integer  :offer_id
      t.string   :gender
    end
  end
end
