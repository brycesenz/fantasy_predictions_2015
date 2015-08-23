require "rubygems"
require "bundler/setup"
require "active_record"

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/app/*.rb").each{ |f| require f }
Dir.glob(project_root + "/app/**/*.rb").each{ |f| require f }
Dir.glob(project_root + "/lib/*.rb").each{ |f| require f }
Dir.glob(project_root + "/lib/**/*.rb").each{ |f| require f }

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

# ['QB', 'RB', 'WR', 'TE', 'K', 'DST'].each do |position|
#   BuildPreseasonData.run(position)
# end

dsts = Player.where(position: 'DST').map(&:name)
puts "dsts = #{dsts.inspect}"

ks = Player.where(position: 'K').map(&:name)
puts "ks = #{ks.inspect}"


# HistoricData::PreseasonRankingAppender.append

if __FILE__ == $0
  puts "Number of Players: #{Player.count}"
  puts "Number of Performances: #{Performance.count}"
end
