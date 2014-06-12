class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :total_chips

      t.timestamps
    end
  end
end
