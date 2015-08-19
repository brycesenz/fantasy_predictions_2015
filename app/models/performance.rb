require 'active_record'

class Performance < ActiveRecord::Base
  belongs_to :player

  attr_accessible :year, :week, :player_team,
    :opposing_team, :position, :home, :points, :passing_attempts,
    :passing_completions, :passing_yards, :passing_touchdowns, 
    :passing_interceptions, :passing_two_points,
    :rushing_attempts, :rushing_yards, :rushing_touchdowns, 
    :rushing_two_points, :receiving_receptions, :receiving_yards,
    :receiving_touchdowns, :receiving_two_points, 
    :fumble_fumbles, :fumble_touchdowns

end