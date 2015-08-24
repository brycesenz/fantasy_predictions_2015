require 'csv'
require 'fuzzy_match'

## DATA FROM:
# http://walterfootball.com/
# http://sports.yahoo.com/news/2014-fantasy-rankings--top-150-204748821.html

# http://www.fantasypros.com/nfl/auction-values/calculator.php

module HistoricData
  class PreseasonRankingAppender
    YEARS = ['2010', '2011', '2012', '2013', '2014']

    class << self
      def append
        YEARS.each do |year|
          data = read_dataset(year)
          Player.all.each do |player|
            append_player_data(data, player, year)
          end
        end
      end

      private
      def read_dataset(year = '2010')
        current_dir = File.dirname(File.absolute_path(__FILE__))
        CSV.read("#{current_dir}/#{year}_preseason_rankings.csv")
      end

      def append_player_data(data, player, year)
        ranking = get_ranking(data, player)
        if ranking.nil?
          puts "#{year} data for #{player.name} not found!"
        else
          player.update_attribute("preseason_rank_#{year}", ranking)
        end
      end

      def get_ranking(data, player)
        player_array = find_player_array(data, player)
        player_array.nil? ? nil : player_array[1].to_i
      end

      def find_player_array(data, player)
        data_names = data.map { |d| d[0] }
        found_name = FuzzyMatch.new(data_names).find(player.name)
        if found_name.present?
          data.select { |d| d[0] == found_name }.first
        else
          nil
        end
      end
    end
  end
end