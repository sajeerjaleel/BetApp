class BetMatch < ActiveRecord::Base
	belongs_to :bet_fixture
	accepts_nested_attributes_for :bet_fixture

	after_create :complete_fixture

	def complete_fixture
		bet_fixture = BetFixture.find bet_fixture_id
		bet_fixture.update_attributes(bet_created: true)
	end

	def self.result (fixture,result) 
		@fixture = fixture
		@bets    = @fixture.bets
		@users    = @bets.collect(&:user)
		
		@home_bets = @bets.where(prediction: "home")
		@draw_bets = @bets.where(prediction: "draw")
		@away_bets = @bets.where(prediction: "away")

		@total_coins = @bets.sum(:coins)
		@home_coins  = @home_bets.sum(:coins)
		@draw_coins  = @draw_bets.sum(:coins)
		@away_coins  = @away_bets.sum(:coins)

		@users.each do |user|

			@user_bets = user.bets.where(bet_fixture_id: @fixture.id)
			@user_coins  = @user_bets.first.coins
			@user_bet = @user_bets.first.prediction

			if @user_bet == "home" and result == "home"

				@user_share = (@user_coins.to_f / @home_coins.to_f)
				@user_win_coin = (@user_share * @total_coins).to_i
				user.coins += @user_win_coin
				user.save
				@user_bets.first.update(coins_won:  @user_win_coin)

			elsif @user_bet == "home" and result != "home"

				@user_lose_coin = (@user_coins).to_i
				@user_bets.first.update(coins_won:  -(@user_lose_coin))

			elsif @user_bet == "draw" and result =="draw"

				@user_share = (@user_coins.to_f  / @draw_coins.to_f)
				@user_win_coin = (@user_share * @total_coins).to_i
				user.coins+= @user_win_coin
				user.save
				@user_bets.first.update(coins_won:  @user_win_coin)


			elsif @user_bet == "draw" and result !="draw"

				@user_lose_coin = (@user_coins).to_i
				@user_bets.first.update(coins_won:  -(@user_lose_coin))

			elsif @user_bet == "away" and result =="away"

				@user_share = (@user_coins.to_f  / @away_coins.to_f)
				@user_win_coin = (@user_share * @total_coins).to_i
				user.coins+= @user_win_coin
				user.save
				@user_bets.first.update(coins_won:  @user_win_coin)

			elsif @user_bet == "away" and result !="away"

				@user_lose_coin = (@user_coins).to_i
				@user_bets.first.update(coins_won:  -(@user_lose_coin))

			end

		end

	end
end
