require 'pry'
require 'minitest/autorun'
require 'minitest/focus'
require 'JSON'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

require "./item"
require "./user"
require "./data_parser"
require "./transaction_parser"
require "./transaction"


class Minitest::Test
  # A little magic here, but this adds a `file_path` helper
  # function that is available in all of our test classes (how?)
  def file_path file_name
    File.expand_path "../data/#{file_name}.json", __FILE__
  end
end
