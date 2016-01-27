class Upvote < ActiveRecord::Base

	belongs_to :track, dependent: :destroy
	belongs_to :user

end