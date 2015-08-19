require 'mechanize'
require 'open-uri'

module FootballDatabase
  class Importer
    class << self
      def import
        rows_array = Parser.get_all_positions
        rows_array.each { |r| import_row(r) }
      end

      private
      def import_row(db_row)
        puts "-------------------------------------------"
        puts "Importing: #{db_row.to_hash}"
        Player.create_or_update_with_db_row(db_row)
      end
    end
  end
end