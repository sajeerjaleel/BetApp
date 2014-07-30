class League < ActiveRecord::Base
	has_many :user_leagues
	has_many :users, through: :user_leagues
  validates :name, presence: true ,:uniqueness => true

	def self.search(search)
    if search
      where('LOWER(name) LIKE ?', "%#{search.downcase}%")
    else
      all
    end
  end

  def users_count
    users = self.users
    return users.length
  end

	def self.sort_by_user(page,search)
    Kaminari.paginate_array(self.search(search).sort_by(&:users_count).reverse).page(page).per(10)
  end

end
