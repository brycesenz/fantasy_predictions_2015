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

  def update_from_db_row(db_row)
    attributes = map_attributes_from_db_row(db_row)
    update_attributes(attributes)
    save!
    self
  end

  private
  def map_attributes_from_db_row(db_row)
    {
      year: db_row.year,
      week: db_row.week,
      player_team: db_row.player_team,
      opposing_team: db_row.opposing_team, 
      position: db_row.position, 
      home: db_row.home, 
      points: db_row.points,
      passing_attempts: db_row.passing_attempts,
      passing_completions: db_row.passing_completions, 
      passing_yards: db_row.passing_yards,
      passing_touchdowns: db_row.passing_touchdowns, 
      passing_interceptions: db_row.passing_interceptions, 
      passing_two_points: db_row.passing_two_points,
      rushing_attempts: db_row.rushing_attempts, 
      rushing_yards: db_row.rushing_yards, 
      rushing_touchdowns: db_row.rushing_touchdowns, 
      rushing_two_points: db_row.rushing_two_points,
      receiving_receptions: db_row.receiving_receptions,
      receiving_yards: db_row.receiving_yards,
      receiving_touchdowns: db_row.receiving_touchdowns,
      receiving_two_points: db_row.receiving_two_points, 
      fumble_fumbles: db_row.fumble_fumbles,
      fumble_touchdowns: db_row.fumble_touchdowns
    }
  end
end