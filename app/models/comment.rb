class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :bet_match

	def status(user)
		status = (user_ids.include? user.id) ? "d" : ""
		status
	end

end
