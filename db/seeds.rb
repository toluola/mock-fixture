# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'toluola7@gmail.com', password: 'test123', role: 'admin')
20.times do 
  Team.create!(
    name: Faker::Team.unique.name
  )
end

120.times do 
  Fixture.create!(
    home_team: Faker::Team.unique.name,
    away_team: Faker::Team.unique.name,
    date_time: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now + 10) 
  )
end

