class User < ActiveRecord::Base

	has_many :tracks, dependent: :destroy
	has_many :upvotes

	has_secure_password
	
	validates :first_name, :password, presence: true
	validates :email, presence: true, uniqueness: true

end