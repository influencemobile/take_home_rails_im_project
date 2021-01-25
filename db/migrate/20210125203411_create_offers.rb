class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :description
      t.timestamps null: false
    end
  end
end
