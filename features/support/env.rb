PROJECT_ROOT_PATH = File.dirname(File.dirname(File.dirname(__FILE__)))
require 'aruba/cucumber'
require 'middleman-core'
require 'middleman-core/step_definitions'
require File.join(PROJECT_ROOT_PATH, 'lib', 'middleman-medium_export')


Before('@debug') do
  Aruba.configure { |config| config.command_launcher = :debug }
end

After('@debug') do
  Aruba.configure { |config| config.command_launcher = :spawn }
end
