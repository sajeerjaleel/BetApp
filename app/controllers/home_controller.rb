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
		@fixture = BetFixture.find (params[:id])
		@placed_bet = Bet.where(bet_fixture_id: params[:id], user_id: current_user.id)
		@bet = Bet.new
	end

	def createbet
		@user = current_user
		@fixture = BetFixture.find (params[:id])
		@bet = Bet.new(bet_params)
		@bet.user_id = current_user.id
		@bet.bet_fixture_id = @fixture.id
		@user.coins = @user.coins - @bet.coins
		return redirect_to bet_path, :alert => "No enough coins" if (@user.coins < 0)
		@user.save
		if @bet.save
			redirect_to home_path, :notice => "Successfully placed Bet"
		else
      render @bet.errors.full_messages
    end
	end

	private

  def bet_params
    params.require(:bet).permit(:prediction, :bet_fixture_id, :user_id, :coins)
  end
	
end
