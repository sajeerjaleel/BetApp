class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team
  has_many :bets, dependent: :destroy
  has_many :comments, dependent: :destroy

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
    first_name != "" && last_name != "" && nick_name != nil && image != nil 
  end

  def fav_team
    if team
      fav = team.team_name
    else
      fav = "not selected"
    end
  end
  
end
