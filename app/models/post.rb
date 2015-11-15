class Post < ActiveRecord::Base
	belongs_to :parent, :class_name => "Post", :foreign_key => "parent_post_id"
	has_many :child_posts, :class_name => "Post", :foreign_key => "parent_post_id"
end
