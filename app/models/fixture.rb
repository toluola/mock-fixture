class Fixture < ApplicationRecord
  include PgSearch::Model
  validates_presence_of :home_team, :away_team, :date_time
  after_save :clear_cache

  pg_search_scope :search_by_home_away_team, against: [:home_team, :away_team],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

    def clear_cache
      $redis.del "fixtures"
    end
end
