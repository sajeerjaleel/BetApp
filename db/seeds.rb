# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
p "deleting teams..."
Team.delete_all

p "creating teams..."

t = Team.find_or_create_by(team_name: 'Arsenal', team_stadium:'Emirates Stadium')
t = Team.find_or_create_by(team_name: 'Aston Villa', team_stadium: 'Villa Park')
t = Team.find_or_create_by(team_name: 'Burnley', team_stadium: 'Turf Moor')
t = Team.find_or_create_by(team_name: 'Chelsea', team_stadium: 'Stamford Bridge')
t = Team.find_or_create_by(team_name: 'Crystal Palace', team_stadium: 'Selhurst Park')
t = Team.find_or_create_by(team_name: 'Everton', team_stadium: 'Goodison Park')
t = Team.find_or_create_by(team_name: 'Hull', team_stadium: 'KC Stadium')
t = Team.find_or_create_by(team_name: 'Leicester', team_stadium: ' King Power Stadium')
t = Team.find_or_create_by(team_name: 'Liverpool', team_stadium: 'Anfield')
t = Team.find_or_create_by(team_name: 'Man City', team_stadium: 'Etihad Stadium')
t = Team.find_or_create_by(team_name: 'Man United', team_stadium: 'Old Trafford')
t = Team.find_or_create_by(team_name: 'Newcastle', team_stadium: 'St James Park')
t = Team.find_or_create_by(team_name: 'QPR', team_stadium: 'Loftus Road')
t = Team.find_or_create_by(team_name: 'Southampton', team_stadium: 'St Marys Stadium')
t = Team.find_or_create_by(team_name: 'Stoke', team_stadium: 'Britannia Stadium')
t = Team.find_or_create_by(team_name: 'Sunderland', team_stadium: 'Stadium of Light')
t = Team.find_or_create_by(team_name: 'Swansea', team_stadium: 'Liberty Stadium')
t = Team.find_or_create_by(team_name: 'Tottenham', team_stadium: 'White Hart Lane')
t = Team.find_or_create_by(team_name: 'West Brom', team_stadium: 'The Hawthorns')
t = Team.find_or_create_by(team_name: 'West Ham', team_stadium: 'Boleyn Ground')

user = User.find_by_email 'sajeerj@qburst.com'
unless user
	user = User.new
	user.email = 'sajeerj@qburst.com'
	user.password = 'password'
	# user.approved = true
	a = user.save(validate: false	)
	user.add_role :admin
end
