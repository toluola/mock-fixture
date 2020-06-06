FactoryBot.define do
  factory :fixture do
    home_team { "liverpool" }
    away_team { "chelsea" }
    date_time { Faker::Time.between(from: DateTime.now - 10, to: DateTime.now + 10)  }
  end
end