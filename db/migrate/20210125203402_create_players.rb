class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :username
      t.string :first_name
      t.string :gender
      t.date :age
      t.timestamps null: false
    end
  end
end
