class Team < ApplicationRecord
  include PgSearch::Model
  validates_presence_of :name
  validates :name, uniqueness: true
  after_save :clear_cache

  pg_search_scope :search_by_name, against: [:name],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

    def clear_cache
      $redis.del "teams"
    end
end
