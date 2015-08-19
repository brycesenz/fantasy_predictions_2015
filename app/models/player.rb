require 'active_record'

class Player < ActiveRecord::Base
  has_many :performances

  attr_accessible :name, :position
  validates :name, presence: true
  validates :position, presence: true

  class << self
    def create_or_update_with_db_row(db_row)
      player = create_or_update_player(db_row)
      player.create_or_update_performance(db_row)
      player
    end

    def create_or_update_player(db_row)
      existing = self.find_by_name(db_row.player_name)
      if existing.present?
        existing.update_attributes(position: db_row.position)
        existing
      else
        self.create(name: db_row.player_name, position: db_row.position)
      end
    end
  end

  def find_performance(year, week)
    performances.find(:first, conditions: { year: year.to_i, week: week.to_i })
  end

  def create_or_update_performance(db_row)
    performance = find_performance(db_row.year, db_row.week)
    if performance.present?
      performance.update_attributes(
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
      )
      performance
    else
      performance = performances.create(
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
      )
    end
    performance
  end
end
