class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :cooldown, :default => 0
      t.boolean :repeatable
      t.string :description
      t.string :controller
      t.string :action
      t.integer :value

      t.timestamps
    end
  end
end


