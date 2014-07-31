class League < ActiveRecord::Base
	has_many :user_leagues
  has_many :requests
	has_many :users, through: :user_leagues
  validates :name, presence: true ,:uniqueness => true
  after_create :join_url

  def join_url
    self.url = rand(36**5).to_s(36)+self.id.to_s
    self.save
  end

	def self.search(search)
    if search
      where('LOWER(name) LIKE ?', "%#{search.downcase}%")
    else
      all
    end
  end

  def request_placed(user)
    reqs = Request.where("league_id = ? AND user_id = ?", self.id,user.id)
    reqs.empty?
  end

  def users_count
    users = self.users
    return users.length
  end

	def self.sort_by_user(page,search)
    Kaminari.paginate_array(self.search(search).sort_by(&:users_count).reverse).page(page).per(10)
  end

end
