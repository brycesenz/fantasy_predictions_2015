require 'csv'

class DataBuilder
  class << self
    private
    def save_to_path(filename)
      directory = File.dirname(File.absolute_path(__FILE__))
      File.expand_path("..", directory) + '/' + filename
    end

    def save_to_file(filename, dataset = [])
      destination = save_to_path(filename)
      CSV.open("#{destination}.csv", "w") do |csv|
        dataset.each do |data_row|
          csv << data_row
        end
      end
    end
  end
end