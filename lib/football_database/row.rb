require 'mechanize'
require 'open-uri'

module FootballDatabase
  class Row
    attr_accessor :position, :year, :week, :row

    def initialize(position, year, week, row)
      @position = position
      @year = year
      @week = week
      @row = row
    end

    def to_hash
      {
        player_name: player_name,
        position: position,
        year: year,
        week: week,
        player_team: player_team,
        opposing_team: opposing_team,
        home: home,
        points: points,
        passing_attempts: passing_attempts,
        passing_completions: passing_completions,
        passing_yards: passing_yards,
        passing_touchdowns: passing_touchdowns,
        passing_interceptions: passing_interceptions,
        passing_two_points: passing_two_points,
        rushing_attempts: rushing_attempts,
        rushing_yards: rushing_yards,
        rushing_touchdowns: rushing_touchdowns,
        rushing_two_points: rushing_two_points,
        receiving_receptions: receiving_receptions,
        receiving_yards: receiving_yards,
        receiving_touchdowns: receiving_touchdowns,
        receiving_two_points: receiving_two_points,
        fumble_fumbles: fumble_fumbles,
        fumble_touchdowns: fumble_touchdowns
      }
    end

    def player_name
      @row[0].text.split(',').first.strip
    end

    def player_team
      @row[0].text.split(',').last.strip
    end

    def opposing_team
      @row[1].text.gsub(/[@]/,'')
    end

    def home
      !@row[1].text.include?('@')
    end

    def points
      @row[2].text.to_i
    end

    def passing_attempts
      @row[3].text.to_i
    end

    def passing_completions
      @row[4].text.to_i
    end

    def passing_yards
      @row[5].text.to_i
    end

    def passing_touchdowns
      @row[6].text.to_i
    end

    def passing_interceptions
      @row[7].text.to_i
    end

    def passing_two_points
      @row[8].text.to_i
    end

    def rushing_attempts
      @row[9].text.to_i
    end

    def rushing_yards
      @row[10].text.to_i
    end

    def rushing_touchdowns
      @row[11].text.to_i
    end

    def rushing_two_points
      @row[12].text.to_i
    end

    def receiving_receptions
      @row[13].text.to_i
    end

    def receiving_yards
      @row[14].text.to_i
    end

    def receiving_touchdowns
      @row[15].text.to_i
    end

    def receiving_two_points
      @row[16].text.to_i
    end

    def fumble_fumbles
      @row[17].text.to_i
    end

    def fumble_touchdowns
      @row[18].text.to_i
    end
  end
end