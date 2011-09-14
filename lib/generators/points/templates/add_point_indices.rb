class AddPointIndices < ActiveRecord::Migration
  def change
    add_index :points, [:controller, :action]
    add_index :point_redemptions, [:point_id, :user_id]
    add_index :point_redemptions, :user_id
    add_index :point_redemptions, :point_id
  end
end
