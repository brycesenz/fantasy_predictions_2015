require_relative 'data_builder'

class BuildGameData < DataBuilder
  class << self
    DATAFIELDS = [ :datapoints, :points, :passing_attempts, 
      :passing_completions, :passing_yards, :passing_touchdowns, 
      :passing_interceptions, :passing_two_points,
      :rushing_attempts, :rushing_yards, :rushing_touchdowns, 
      :rushing_two_points, :receiving_receptions, :receiving_yards,
      :receiving_touchdowns, :receiving_two_points, 
      :fumble_fumbles, :fumble_touchdowns ]

    def run(position = 'QB')
      players = Player.where(position: position)
      years = [2010, 2011, 2012, 2013]
      dataset = [headers]
      players.each do |player|
        years.each do |year|
          dataset << build_row(player, year)
        end
      end
      filename = position.downcase + '_preseason_data'
      save_to_file(filename, dataset)
    end

    private
    def headers
      ['player_name', 'year', 'target_points', *DATAFIELDS]
    end

    def build_row(player, year)
      array = [player.name, year]
      array << target_variable(player, year)
      DATAFIELDS.each do |data_field|
        array << player.send("#{data_field}_in", year)
      end
      array
    end

    def target_variable(player, year)
      player.send(:points_in, year + 1)
    end
  end
end