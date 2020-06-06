class Team < ApplicationRecord
  include PgSearch::Model
  validates_presence_of :name
  validates :name, uniqueness: true

  pg_search_scope :search_by_name, against: [:name],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }
end
