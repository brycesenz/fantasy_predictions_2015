require 'mechanize'
require 'open-uri'

module FootballDatabase
  class Parser
    SITE = 'http://www.footballdb.com/fantasy-football/index.html'

    class << self
      def agent
        @agent ||= Mechanize.new
      end

      def get_all_rows(position, year, week)
        table = get_table(position, year, week)
        num_rows = get_num_rows(position, year, week)
        array = []
        num_rows.times do |row|
          array << get_db_row(position, year, week, row + 1)
        end
        array
      end

      def get_db_row(position, year, week, row_num)
        raise StandardError, "Invalid row" if row_num < 1
        table = get_table(position, year, week)
        # Add 1, and use a base of 1, to adjust for the two header rows
        table_row = table.search('tr')[1 + row_num].search('td')
        Row.new(position, year, week, table_row)
      end

      def get_num_rows(position, year, week)
        table = get_table(position, year, week)
        # Subtract the two header rows
        table.css('tr').length - 2
      end

      private
      def get_table(position, year, week)
        url = SITE + "?pos=#{position}&yr=#{year}&wk=#{week}"
        agent.get(url).search('table.statistics')
      end
    end
  end
end