require "rubygems"
require "bundler/setup"

require 'pg'
require 'active_record'
require 'yaml'

namespace :db do
  desc "Migrate the DB"
  task :migrate do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  desc "Create the DB"
  task :create do
    connection_details = YAML::load(File.open('config/database.yml'))
    admin_connection = connection_details.merge({'database'=> 'postgres', 
                                                'schema_search_path'=> 'public'}) 
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.create_database(connection_details.fetch('database'))
  end

  desc "Drop the DB"
  task :drop do
    connection_details = YAML::load(File.open('config/database.yml'))
    admin_connection = connection_details.merge({'database'=> 'postgres', 
                                                'schema_search_path'=> 'public'}) 
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.drop_database(connection_details.fetch('database'))
  end
end

namespace :football_database do
  desc "Import Football Database data"
  task :import do
    project_root = File.dirname(File.absolute_path(__FILE__))
    Dir.glob(project_root + "/app/models/*.rb").each{ |f| require f }
    Dir.glob(project_root + "/lib/*.rb").each{ |f| require f }
    Dir.glob(project_root + "/lib/**/*.rb").each{ |f| require f }

    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)

    FootballDatabase::Importer.import
  end
end
