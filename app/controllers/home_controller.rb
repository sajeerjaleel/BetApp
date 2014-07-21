class HomeController < ApplicationController
 before_filter :authenticate_user!, :except => ["index"]
	def index
	end

	def new
		@count = BetMatch.count
		@matches = BetMatch.all
	end

	def fixtures
		@fixtures = Fixture.all
	end

	def results
		@results = Result.all
	end

	def table
		@epldata = Table.all
		@a = 0
		@count = 1
	end

	def bet
		@fixture = BetFixture.find_by(params[:id])
	end
	
end
