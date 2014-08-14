require 'open-uri'

task :import => :environment do

  Table.delete_all
  Fixture.delete_all
  Result.delete_all

	#Table
	page= Nokogiri::HTML(open("http://www.bbc.com/sport/football/tables")) 
	page.search('//tr').each do |line|
	 	position = line.search('td.position/span.position-number/text()').to_s
	  team = line.search('td.team-name/a/text()').to_s
	  played = line.search('td.played/text()').to_s
	  won = line.search('td.won/span/text()').to_s
	  drawn = line.search('td.drawn/text()').to_s
	  lost = line.search('td.lost/text()').to_s
	  goalfor = line.search('td.for/text()').to_s
	  goalagainst = line.search('td.against/text()').to_s
	  goaldifference = line.search('td.goal-difference/text()').to_s
	  points = line.search('td.points/text()').to_s

	  p = Table.new 
	 		p.position = position
	 	  p.team = team
	 	  p.played = played
	 	  p.won = won
	    p.drawn = drawn
	    p.lost = lost
	 	  p.goalfor = goalfor
	 	  p.goalagainst = goalagainst
	 	  p.goaldifference = goaldifference
	 	  p.points = points	  
	  p.save
	end

	a = Table.first
	a.delete
	b = Table.first
	b.delete

	#Fixtures
	page= Nokogiri::HTML(open("http://www.premierleague.com/en-gb/matchday/matches.html?paramClubId=ALL&paramComp_100=true&view=.dateSeason"))  
	page.search('//tr').each do |line|
	  	
	  date = line.search('th/text()').to_s
	 	time = line.search('td.time/text()').to_s
	 	teams = line.search('td.clubs/a/text()').to_s
	 	location = line.search('td.location/a/text()').to_s.strip.gsub("'","")

	  f = Fixture.new
	 	  f.date = date 
	 	  f.time = time
	 	  f.teams = teams
	 	  f.location = location
	 	f.save
	end

	f = Fixture.where(:date => "",:time => "", :teams => "", :location => "")
	f.delete_all
	f = Fixture.where(:date => "ClubPldPts")
	f.delete_all

	#Results
	page= Nokogiri::HTML(open("http://www.premierleague.com/en-gb/matchday/results.html?paramComp_100=true&view=.dateSeason"))  
	page.search('//tr').each do |line|
	  
		date = line.search('th/text()').to_s
		hometeam = line.search('td.rHome/a/text()').to_s
		score = line.search('td.score/a/text()').to_s
		awayteam = line.search('td.rAway/a/text()').to_s
		location = line.search('td.location/a/text()').to_s.strip.gsub("'","")

	  f = Result.new
		  f.date = date 
		  f.hometeam = hometeam
		  f.score = score
		  f.awayteam = awayteam
		  f.location = location
		f.save
	end

	f = Result.where(:date => "ClubPldPts")
	f.delete_all

	# # ================================================

	#  p "Oraganising fetched data to BetFixture model..."

	#  with_date = Fixture.where('date != ?',"").map(&:id)
	#  count = with_date.count
	#  i = 0
	#  while (with_date[i] != with_date.last)
	#  	p "==========================="
	#  	p with_date[i]
	#  	fixs = Fixture.where("id BETWEEN ? AND ?",(with_date[i]+1),(with_date[i+1]-1))
	#  	date = Fixture.find(with_date[i]).date
	#  	fixs.each do |fix|
	#  		bet_fixture = BetFixture.new
	#  		bet_fixture.date = date
	#  		bet_fixture.time = fix.time
	#  		teams = fix.teams.split(" v ")
	#  		bet_fixture.home_team = teams[0]
	#  		bet_fixture.away_team = teams[1]
	#  		bet_fixture.location = fix.location
	#  		bet_fixture.save
	#  		p "<<<#{bet_fixture.id}>>>created with date <<<<<< #{date} >>>>>>>"
	#  	end
	#  	i = i+1
	#  end
	#  p "final adding..........."
	#  # ==========================================================
	#  date = Fixture.find(with_date.last).date
	#  fixs = Fixture.where("id BETWEEN ? AND ?",(with_date.last+1),(Fixture.last.id))
	#  fixs.each do |fix|
	#  		bet_fixture = BetFixture.new
	#  		bet_fixture.date = date
	#  		bet_fixture.time = fix.time
	#  		teams = fix.teams.split(" v ")
	#  		bet_fixture.home_team = teams[0]
	#  		bet_fixture.away_team = teams[1]
	#  		bet_fixture.location = fix.location
	#  		bet_fixture.save
	#  		p "<<<#{bet_fixture.id}>>>created with date <<<<<< #{date} >>>>>>>"
	#  	end

end