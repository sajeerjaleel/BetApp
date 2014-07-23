class HomeController < ApplicationController
 before_filter :authenticate_user!, :except => ["index"]
	def index
	end

	def new
		@count = BetMatch.count
		@matches = BetMatch.where('completed = ? and done = ?', false, false)
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
		@placed_bet = Bet.where(bet_fixture_id: params[:id], user_id: current_user.id)
		@bet = Bet.new
		@comment = Comment.new
		@bet_comments = @fixture.comments.order("created_at DESC").first(5)
	end

	def create_comment
		@bet_fixture = BetFixture.find params[:id]
		comment = @bet_fixture.comments.create(comment_params)
		comment.user_id = current_user.id
		comment.save
		redirect_to bet_path
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

	private

  def bet_params
    params.require(:bet).permit(:prediction, :bet_fixture_id, :user_id, :coins)
  end

  def comment_params
  	params.require(:comment).permit(:content)
  end
	
end
