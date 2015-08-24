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
    :fumble_fumbles, :fumble_touchdowns,
    :pat_attempts, :pat_made, :fg_attempts, :fg_made,
    :fifty_yd_fg_made,
    :defensive_sacks, :defensive_interceptions, :defensive_safeties,
    :defensive_fumble_recoveries, :defensive_blocked_kicks, :defensive_touchdowns,
    :defensive_points_against, :defensive_passing_yards_allowed, 
    :defensive_rushing_yards_allowed, :defensive_total_yards_allowed

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
      fumble_touchdowns: db_row.fumble_touchdowns,
      pat_attempts: db_row.pat_attempts,
      pat_made: db_row.pat_made,
      fg_attempts: db_row.fg_attempts,
      fg_made: db_row.fg_made,
      fifty_yd_fg_made: db_row.fifty_yd_fg_made,
      defensive_sacks: db_row.defensive_sacks,
      defensive_interceptions: db_row.defensive_interceptions,
      defensive_safeties: db_row.defensive_safeties,
      defensive_fumble_recoveries: db_row.defensive_fumble_recoveries,
      defensive_blocked_kicks: db_row.defensive_blocked_kicks,
      defensive_touchdowns: db_row.defensive_touchdowns,
      defensive_points_against: db_row.defensive_points_against,
      defensive_passing_yards_allowed: db_row.defensive_passing_yards_allowed,
      defensive_rushing_yards_allowed: db_row.defensive_rushing_yards_allowed,
      defensive_total_yards_allowed: db_row.defensive_total_yards_allowed
    }
  end
end