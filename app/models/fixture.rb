class Fixture < ApplicationRecord
  include PgSearch::Model
  validates_presence_of :home_team, :away_team, :date_time

  pg_search_scope :search_by_home_away_team, against: [:home_team, :away_team],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }
end
