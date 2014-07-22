class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :team
  has_many :bets, dependent: :destroy
  has_many :comments, dependent: :destroy

  def full_name
  	if nick_name != "" && nick_name != nil
  		nick_name
  	elsif first_name != "" && first_name != nil
  		first_name
  	else
  		"Anonymous"
  	end
  end
  
end
