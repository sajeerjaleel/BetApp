class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team
  has_many :bets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_leagues
  has_many :leagues, through: :user_leagues
  has_many :requests, dependent: :destroy


  def full_name
  	if nick_name != "" && nick_name != nil
  		nick_name
  	elsif first_name != "" && first_name != nil
  		first_name
  	else
  		email
  	end
  end

  def updated?
    first_name != "" && last_name != "" && nick_name != nil
  end

  def fav_team
    if team
      fav = team.team_name
    else
      fav = "not selected"
    end
  end

  def has_admin_prev
    leagues = League.where(admin_id: id)
    has_prev = leagues.count == 0 ? false : true
  end
  
  def bet_completed?(fixture_id)
    home = bets.where("bet_fixture_id = ? AND prediction = ?",fixture_id,"home")
    draw = bets.where("bet_fixture_id = ? AND prediction = ?",fixture_id,"draw")
    away = bets.where("bet_fixture_id = ? AND prediction = ?",fixture_id,"away")
    p "==================================================================" 
     p bet_completed = !(home.length.zero? || draw.length.zero? || away.length.zero?)
     p "home" + home.length.to_s
     p  "away" + away.length.to_s
     p "draw" + draw.length.to_s
    p "==================================================================" 

    bet_completed
  end

  def valid_bet?(prediction,fixture_id)
    bet_count = bets.where("bet_fixture_id = ? AND prediction = ?",fixture_id,prediction).length
    validity = bet_count == 0 ? true : false
  end
end
