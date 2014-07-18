# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

t = Team.find_or_create_by(team_name: 'Arsenal', team_stadium:'Emirates Stadium')
t = Team.find_or_create_by(team_name: 'Aston Villa', team_stadium: 'Villa Park')
t = Team.find_or_create_by(team_name: 'Burnley', team_stadium: 'Turf Moor')
t = Team.find_or_create_by(team_name: 'Chelsea', team_stadium: 'Stamford Bridge')
t = Team.find_or_create_by(team_name: 'Crystal Palace', team_stadium: 'Selhurst Park')
t = Team.find_or_create_by(team_name: 'Everton', team_stadium: 'Goodison Park')
t = Team.find_or_create_by(team_name: 'Hull City', team_stadium: 'KC Stadium')
t = Team.find_or_create_by(team_name: 'Leicester City', team_stadium: ' King Power Stadium')
t = Team.find_or_create_by(team_name: 'Liverpool', team_stadium: 'Anfield')
t = Team.find_or_create_by(team_name: 'Manchester City', team_stadium: 'Etihad Stadium')
t = Team.find_or_create_by(team_name: 'Manchester United', team_stadium: 'Old Trafford')
t = Team.find_or_create_by(team_name: 'Newcastle United', team_stadium: 'St James Park')
t = Team.find_or_create_by(team_name: 'Queens Park Rangers', team_stadium: 'Loftus Road')
t = Team.find_or_create_by(team_name: 'Southampton', team_stadium: 'St Marys Stadium')
t = Team.find_or_create_by(team_name: 'Stoke City', team_stadium: 'Britannia Stadium')
t = Team.find_or_create_by(team_name: 'Sunderland', team_stadium: 'Stadium of Light')
t = Team.find_or_create_by(team_name: 'Swansea City', team_stadium: 'Liberty Stadium')
t = Team.find_or_create_by(team_name: 'Tottenham Hotspur', team_stadium: 'White Hart Lane')
t = Team.find_or_create_by(team_name: 'West Bromwich Albion', team_stadium: 'The Hawthorns')
t = Team.find_or_create_by(team_name: 'West Ham United', team_stadium: 'Boleyn Ground')
