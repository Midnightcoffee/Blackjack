class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_id
      t.string :level
      t.integer :player_bet
      t.string :player_hand
      t.string :dealer_hand
      t.text :deck_sleeve
      t.text :message

      t.timestamps
    end
  end
end
