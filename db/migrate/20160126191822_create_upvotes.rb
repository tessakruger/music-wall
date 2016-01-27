class CreateUpvotes < ActiveRecord::Migration
	def change
		create_table :upvotes do |t|
	  	t.integer :upvote
  	end
	end
end