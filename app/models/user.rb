class User < ActiveRecord::Base

	has_many :tracks, dependent: :destroy
	
	validates :first_name, :password, presence: true
	validates :email, presence: true, uniqueness: true

end