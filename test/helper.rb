if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/test/'
    add_filter '/.bundle/'
  end
end

require 'test/unit'
require 'fluent/log'
require 'fluent/test'
