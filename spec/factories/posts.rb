FactoryGirl.define do
  factory :post do
    content "MyString"
votes_count 1
user_id 1
parent_post_id 1
  end

end
