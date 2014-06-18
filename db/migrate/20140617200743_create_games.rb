class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_id
      t.integer :player_bet
      t.string :player_hand
      t.text :deck_sleeve

      t.timestamps
    end
  end
end
