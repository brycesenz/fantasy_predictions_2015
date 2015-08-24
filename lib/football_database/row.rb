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
        fumble_touchdowns: fumble_touchdowns,
        pat_attempts: pat_attempts,
        pat_made: pat_made,
        fg_attempts: fg_attempts,
        fg_made: fg_made,
        fifty_yd_fg_made: fifty_yd_fg_made,
        defensive_sacks: defensive_sacks,
        defensive_interceptions: defensive_interceptions,
        defensive_safeties: defensive_safeties,
        defensive_fumble_recoveries: defensive_fumble_recoveries,
        defensive_blocked_kicks: defensive_blocked_kicks,
        defensive_touchdowns: defensive_touchdowns,
        defensive_points_against: defensive_points_against,
        defensive_passing_yards_allowed: defensive_passing_yards_allowed,
        defensive_rushing_yards_allowed: defensive_rushing_yards_allowed,
        defensive_total_yards_allowed: defensive_total_yards_allowed
      }
    end

    def player_name
      if dst?
        formatted_dst_name(@row[0].text)
      else
        @row[0].text.split(',').first.strip
      end
    end

    def formatted_dst_name(string)
      split = string.split /(?=[A-Z])/
      split.each { |word| word.strip! }
      formatted = split.uniq.join(' ')
      formatted
    end

    def player_team
      if dst?
        player_name
      else
        @row[0].text.split(',').last.strip
      end
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
      kicker_or_dst? ? nil : @row[3].text.to_i
    end

    def passing_completions
      kicker_or_dst? ? nil : @row[4].text.to_i
    end

    def passing_yards
      kicker_or_dst? ? nil : @row[5].text.to_i
    end

    def passing_touchdowns
      kicker_or_dst? ? nil : @row[6].text.to_i
    end

    def passing_interceptions
      kicker_or_dst? ? nil : @row[7].text.to_i
    end

    def passing_two_points
      kicker_or_dst? ? nil : @row[8].text.to_i
    end

    def rushing_attempts
      kicker_or_dst? ? nil : @row[9].text.to_i
    end

    def rushing_yards
      kicker_or_dst? ? nil : @row[10].text.to_i
    end

    def rushing_touchdowns
      kicker_or_dst? ? nil : @row[11].text.to_i
    end

    def rushing_two_points
      kicker_or_dst? ? nil : @row[12].text.to_i
    end

    def receiving_receptions
      kicker_or_dst? ? nil : @row[13].text.to_i
    end

    def receiving_yards
      kicker_or_dst? ? nil : @row[14].text.to_i
    end

    def receiving_touchdowns
      kicker_or_dst? ? nil : @row[15].text.to_i
    end

    def receiving_two_points
      kicker_or_dst? ? nil : @row[16].text.to_i
    end

    def fumble_fumbles
      kicker_or_dst? ? nil : @row[17].text.to_i
    end

    def fumble_touchdowns
      kicker_or_dst? ? nil : @row[18].text.to_i
    end

    def pat_attempts
      kicker? ? @row[3].text.to_i : nil
    end

    def pat_made
      kicker? ? @row[4].text.to_i : nil
    end

    def fg_attempts
      kicker? ? @row[5].text.to_i : nil
    end

    def fg_made
      kicker? ? @row[6].text.to_i : nil
    end

    def fifty_yd_fg_made
      kicker? ? @row[7].text.to_i : nil
    end

    def defensive_sacks
      dst? ? @row[3].text.to_i : nil
    end

    def defensive_interceptions
      dst? ? @row[4].text.to_i : nil
    end

    def defensive_safeties
      dst? ? @row[5].text.to_i : nil
    end

    def defensive_fumble_recoveries
      dst? ? @row[6].text.to_i : nil
    end

    def defensive_blocked_kicks
      dst? ? @row[7].text.to_i : nil
    end

    def defensive_touchdowns
      dst? ? @row[8].text.to_i : nil
    end

    def defensive_points_against
      dst? ? @row[9].text.to_i : nil
    end

    def defensive_passing_yards_allowed
      dst? ? @row[10].text.to_i : nil
    end

    def defensive_rushing_yards_allowed
      dst? ? @row[11].text.to_i : nil
    end

    def defensive_total_yards_allowed
      dst? ? @row[12].text.to_i : nil
    end

    private
    def kicker_or_dst?
      kicker? || dst?
    end

    def dst?
      ['DST'].include?(@position)
    end

    def kicker?
      ['K'].include?(@position)
    end
  end
end