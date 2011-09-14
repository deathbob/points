class CreatePointRedemptions < ActiveRecord::Migration
  def change
    create_table :point_redemptions do |t|
      t.integer :user_id
      t.integer :point_id
      t.integer :value

      t.timestamps
    end
  end
end
