class BetMatch < ActiveRecord::Base
	has_many :bet_fixtures
	after_create :complete_fixture

	def complete_fixture
		bet_fixture = BetFixture.find bet_fixture_id
		bet_fixture.update_attributes(bet_created: true)
	end
end
