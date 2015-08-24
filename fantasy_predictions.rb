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


LOAD_FOOTBALLDB_DATA = false
APPEND_HISTORIC_DATA = false
BUILD_MODEL_DATASETS = false
#------------------------------------------------------------------------------
# Step 1:  Import all basic data from footballdb.com
#------------------------------------------------------------------------------
if LOAD_FOOTBALLDB_DATA
  FootballDatabase::Importer.import
  puts "Number of QBs: #{Player.where(position: 'QB').count}"
  puts "Number of RBs: #{Player.where(position: 'RB').count}"
  puts "Number of WRs: #{Player.where(position: 'WR').count}"
  puts "Number of TEs: #{Player.where(position: 'TE').count}"
  puts "Number of Ks: #{Player.where(position: 'K').count}"
  puts "Number of DSTs: #{Player.where(position: 'DST').count}"
end

#------------------------------------------------------------------------------
# Step 2:  Append other historic data
#------------------------------------------------------------------------------
if APPEND_HISTORIC_DATA
  HistoricData::PreseasonRankingAppender.append
  puts "Players without 2010 rank: #{Player.where(preseason_rank_2010: nil).count}"
  puts "Players without 2010 rank: #{Player.where(preseason_rank_2011: nil).count}"
  puts "Players without 2010 rank: #{Player.where(preseason_rank_2012: nil).count}"
  puts "Players without 2010 rank: #{Player.where(preseason_rank_2013: nil).count}"
  puts "Players without 2010 rank: #{Player.where(preseason_rank_2014: nil).count}"
  puts "Players without 2010 rank: #{Player.where(preseason_rank_2015: nil).count}"
end

#------------------------------------------------------------------------------
# Step 3:  Build datasets for use in model building
#------------------------------------------------------------------------------
if BUILD_MODEL_DATASETS
  ['QB', 'RB', 'WR', 'TE', 'K', 'DST'].each do |position|
    puts "Building #{position} dataset..."
    BuildPreseasonData.run(position)
  end
end

#------------------------------------------------------------------------------
# Step 4:  Build R Models
#------------------------------------------------------------------------------
#
# R scripts are located in lib/r_models/
#
if __FILE__ == $0
  puts "Number of Players: #{Player.count}"
  puts "Number of Performances: #{Performance.count}"
end
