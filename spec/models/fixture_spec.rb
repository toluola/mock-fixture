require 'rails_helper'

RSpec.describe Fixture, type: :model do
  it { should validate_presence_of(:home_team) }
  it { should validate_presence_of(:away_team) }
  it { should validate_presence_of(:date_time) }
end
