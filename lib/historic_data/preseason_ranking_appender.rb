require 'csv'
require 'fuzzy_match'

## DATA FROM:
# http://walterfootball.com/
# http://sports.yahoo.com/news/2014-fantasy-rankings--top-150-204748821.html

# http://www.fantasypros.com/nfl/auction-values/calculator.php

module HistoricData
  class PreseasonRankingAppender
    # YEARS = ['2010', '2011', '2012', '2013', '2014']
    YEARS = ['2010']

    class << self
      def append
        YEARS.each do |year|
          data = read_dataset(year)
          # puts "data = #{data.inspect}"
          Player.first(1).each do |player|
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
        ranking = find_fuzzy_row(data, player)
        if ranking.nil?
          puts "#{year} data for #{player.name} not found!"
        else
          player.update_attribute("preseason_rank_#{year}", ranking)
        end
      end

      def find_fuzzy_ranking(data, player)
        data_names = data.map { |d| d[0] }
        match = FuzzyMatch.new(data_names).find(player.name)
        ranking_array = data.select { |d| d[0] == match }
        # puts "ranking_array = #{ranking_array}"
        ranking_array.present? ? ranking_array[1].to_i : nil
      end
    end
  end
end