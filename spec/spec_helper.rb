require 'rubygems'

spec_root = File.join(File.dirname(__FILE__), '..')
Dir.glob(spec_root + "/app/models/*.rb").each{ |f| require f }
Dir.glob(spec_root + "/spec/support/*.rb").each{ |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"
end
