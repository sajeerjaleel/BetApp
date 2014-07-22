class Bet < ActiveRecord::Base
	belongs_to :user 
	belongs_to :bet_fixture 

	validates :user_id, :uniqueness => {:scope => :bet_fixture_id}
end
