class BetMatch < ActiveRecord::Base
	belongs_to :bet_fixture
	after_create :complete_fixture

	def complete_fixture
		bet_fixture = BetFixture.find bet_fixture_id
		bet_fixture.update_attributes(bet_created: true)
	end
end
