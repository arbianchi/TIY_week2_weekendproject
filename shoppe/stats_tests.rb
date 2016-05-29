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
require "./stats"

class Minitest::Test
  def file_path file_name
    File.expand_path "../data/#{file_name}.json", __FILE__
  end
end

class StatToolsTests < Minitest::Test

  def test_find_frequent_buyer
    t = TransactionParser.new file_path("transactions")
    t.parse!
    d = DataParser.new file_path("data")
    d.parse!
    shoppe = StatTools.new t,d
    assert_equal shoppe.find_frequent_buyer,"Miss Maxwell Gaylord"
  end

  def test_ergo_lamps_sold
    t = TransactionParser.new file_path("transactions")
    t.parse!
    d = DataParser.new file_path("data")
    d.parse!
    shoppe = StatTools.new t,d
    assert_equal shoppe.ergo_lamps_sold, 31
  end

  def test_sold_from_tools
    t = TransactionParser.new file_path("transactions")
    t.parse!
    d = DataParser.new file_path("data")
    d.parse!
    shoppe = StatTools.new t,d
    assert_equal shoppe.sold_from_tools, 198
  end

  def test_total_revenue
    t = TransactionParser.new file_path("transactions")
    t.parse!
    d = DataParser.new file_path("data")
    d.parse!
    shoppe = StatTools.new t,d
    assert_equal shoppe.total_revenue, 65696.65
  end

  def test_highest_grossing_category
    t = TransactionParser.new file_path("transactions")
    t.parse!
    d = DataParser.new file_path("data")
    d.parse!
    shoppe = StatTools.new t,d
    assert_equal shoppe.highest_grossing_category, "Books"
  end

end
