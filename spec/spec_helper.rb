require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
end

# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

Dir['./spec/shared/**/*.rb'].sort.each { |f| require f }
require_relative '../lib/necklace'
require_relative 'spec'

require 'rspec'

RSpec.configure do |config|
  config.order = 'random'
end
