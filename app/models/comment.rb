class Comment < ActiveRecord::Base 
	
	include VoteableShankarOct

	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	belongs_to :post
	
	validates :comment, presence: true

end
