class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.text :content
      t.text :title
      t.references :user
      t.string :source_type
      t.string :url
      t.integer :url_refresh_count

      t.timestamps
    end
    add_index :data, :user_id
  end
end
