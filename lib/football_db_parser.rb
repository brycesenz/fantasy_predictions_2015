require 'rubygems'
require 'mechanize'
require 'open-uri'

class FootballDbParser
  SITE = 'http://www.footballdb.com/fantasy-football/index.html'
  POSITIONS = ['QB']
  YEARS = ['2010', '2011', '2012', '2013', '2014']
  WEEKS = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17']

  class << self
    def agent
      @agent ||= Mechanize.new
    end

    def get_db_row(position, year, week, row_num)
      raise StandardError, "Invalid row" if row_num < 1
      table_row = get_row(position, year, week, row_num)
      DbRow.new(position, year, week, table_row)
    end

    private
    def get_row(position, year, week, row_num = 1)
      table = get_table(position, year, week)
      table.search('tr')[1 + row_num].search('td')
    end

    def get_table(position, year, week)
      url = SITE + "?pos=#{position}&yr=#{year}&wk=#{week}"
      agent.get(url).search('table.statistics')
    end
  end

  class DbRow
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
      @row[1].text.gsub!(/[@]/,'')
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