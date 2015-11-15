class AddPositiveToLike < ActiveRecord::Migration
  def change
    add_column :likes, :positive, :boolean
  end
end
