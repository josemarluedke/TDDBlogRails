class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :limit => 250, :null => false
      t.string :excerpt, :limit => 250, :null => true
      t.text :body, :null => false
      t.boolean :allow_comments, :default => true, :null => false
      t.references :user, :null => false

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
