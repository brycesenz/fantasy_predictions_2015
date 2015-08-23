require 'mechanize'
require 'open-uri'

module FootballDatabase
  class Importer
    POSITIONS = ['QB', 'RB', 'WR', 'TE', 'K', 'DST']
    YEARS = ['2010', '2011', '2012', '2013', '2014']
    WEEKS = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17']

    class << self
      def import
        POSITIONS.each do |position|
          get_all_years(position)
        end
      end

      private
      def get_all_years(position)
        YEARS.each do |year|
          get_all_weeks(position, year)
        end
      end

      def get_all_weeks(position, year)
        WEEKS.each do |week|
          db_rows = Parser.get_all_rows(position, year, week)
          db_rows.each { |db_row| import_row(db_row) }
        end
      end

      def import_row(db_row)
        puts "-------------------------------------------"
        puts "Importing: #{db_row.to_hash}"
        Player.create_or_update_with_db_row(db_row)
      end
    end
  end
end