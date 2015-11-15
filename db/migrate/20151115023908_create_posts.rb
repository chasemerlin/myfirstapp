class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :votes_count
      t.integer :user_id
      t.integer :parent_post_id

      t.timestamps null: false
    end
  end
end
