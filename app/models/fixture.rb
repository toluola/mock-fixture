class Fixture < ApplicationRecord
  validates_presence_of :home_team, :away_team, :date_time

end
