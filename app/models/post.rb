class Post < ActiveRecord::Base
	validates_presence_of :content, :votes_count

	belongs_to :parent, :class_name => "Post", :foreign_key => "parent_post_id"
	has_many :child_posts, :class_name => "Post", :foreign_key => "parent_post_id"
	belongs_to :user
end
