class BetMatchPolicy
  attr_reader :user, :bet_match

  def initialize(user, bet_match)
    @user = user
    @bet_match = bet_match
  end

  def new?
  	is_admin?
  end

  def edit?
  	is_admin?
  end

  def index?
  	is_admin?
  end

  def update?
  	is_admin?
  end

  def remove_bets?
  	is_admin?
  end

  def bet?
    BetMatch.where('completed = ? and done = ?', false, false).include?(@bet_match)
  end

  def is_admin?
  	user.has_role? :admin
  end
end