class CreateActionLists < ActiveRecord::Migration
  def change
    create_table :action_lists do |t|
      t.integer :datum_id

      t.timestamps
    end
  end
end
