class HomeController < ApplicationController

	def index
	end

	def new
		
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
	
end
