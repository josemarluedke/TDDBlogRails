class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name, :limit => 100, :null => false
      t.string :email, :limit => 100, :null => false
      t.string :url, :limit => 255, :null => false
      t.boolean :active, :default => false, :null => false
      t.string :body, :null => false
      t.references :post

      t.timestamps
    end
    add_index :comments, :post_id
  end
end
