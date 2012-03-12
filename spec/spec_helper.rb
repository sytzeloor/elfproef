$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'rspec'
require 'elfproef'

Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each do |file|
  require file unless file =~ /fakeweb\/.*\.rb/
end

RSpec.configure do |config|

  config.before :each do
  end

  config.after :each do
  end
end