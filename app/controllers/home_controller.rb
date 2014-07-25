class HomeController < ApplicationController
 before_filter :authenticate_user!, :except => ["index"]

	def index
	 	@team_coins= []
	 	@team_users = []
  	Team.includes(:users).all.collect{|t| @team_coins << [t.team_name, t.users.collect(&:coins).sum]}.inspect 
  	Team.includes(:users).all.collect{|t| @team_users << [t.team_name, t.users.count]}.inspect 	
		@users = User.where('team_id IS NOT NULL')
	end

	def new
		@matches = BetMatch.where('completed = ? and done = ?', false, false)
		@count = @matches.count
	end

	def fixtures
		@fixtures = Fixture.all
	end

	def results
		@results = Result.all
	end

	def delete_comment
		@comment = Comment.find params[:comment_id]
		@comment.destroy
		respond_to do |format|
      format.js
    end
	end

	def table
		@epldata = Table.all
		@a = 0
		@count = 1
	end

	def comments
		@comment = Comment.new
		@fixture = BetFixture.find params[:id]
		@bet_comments = @fixture.comments.order('created_at DESC').page(params[:page]).per(10)
	end
	
	def bet
		@fixture = BetFixture.find (params[:id])
		@fixture_bets = @fixture.bets
		@predictions = ["home","draw","away"]
		@home_max = @fixture_bets.where(prediction: "home").maximum(:coins)
		@away_max = @fixture_bets.where(prediction: "away").maximum(:coins)
		@draw_max = @fixture_bets.where(prediction: "draw").maximum(:coins)
		@placed_bet = Bet.where(bet_fixture_id: params[:id], user_id: current_user.id)
		@bet = Bet.new
		@comment = Comment.new
		@bet_comments = @fixture.comments.order("created_at DESC").first(5)
	end

	def create_comment
		@bet_fixture = BetFixture.find params[:id]
		@fixture = @bet_fixture
		comment = @bet_fixture.comments.create(comment_params)
		comment.user_id = current_user.id
		comment.save
		path = params[:page_number] == "1" ? bet_path : bet_comments_path(@bet_fixture.id)
		redirect_to path
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

	def vote
		@comment = Comment.find(params[:comment])
		 	unless @comment.user_ids.include? params[:user].to_i
				@comment.user_ids += [params[:user].to_i]
				if params[:type] == "like"
					@comment.like += 1
				elsif params[:type] == "dislike"
					@comment.dislike +=1
				end	
				@comment.save	
			end	
		respond_to do |format|
      format.js
    end
	end

	def coins_predicted
	bet_fixture = BetFixture.find params[:bet_fixture_id]
	bets = bet_fixture.bets
	home_bets = bets.where(prediction: "home")
  draw_bets = bets.where(prediction: "draw")
  away_bets = bets.where(prediction: "away")
  total_coins = bets.sum(:coins) + params[:coins].to_i
  home_coins  = home_bets.sum(:coins)
  draw_coins  = draw_bets.sum(:coins)
  away_coins  = away_bets.sum(:coins)
  user_coins = params[:coins].to_i

  if params[:prediction] == "home"
  		home_coins += params[:coins].to_i
      user_share = (user_coins.to_f / home_coins.to_f)
      @user_win_coin = user_share * total_coins
  elsif params[:prediction] == "draw"
  	draw_coins += params[:coins].to_i
      user_share = (user_coins.to_f  / draw_coins.to_f)
      @user_win_coin = user_share * total_coins
  elsif params[:prediction] == "away"
  	away_coins += params[:coins].to_i
      user_share = (user_coins.to_f  / away_coins.to_f)
      @user_win_coin = user_share * total_coins
  end
	@user_win_coin = @user_win_coin.to_i
  respond_to do |format|
      format.js
    end
	end

	private

  def bet_params
    params.require(:bet).permit(:prediction, :bet_fixture_id, :user_id, :coins)
  end

  def comment_params
  	params.require(:comment).permit(:content)
  end
	
end
