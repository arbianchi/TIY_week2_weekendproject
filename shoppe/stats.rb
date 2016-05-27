require 'JSON'
require "./item"
require "./user"
require "./data_parser"
require "./transaction_parser"
require "./transaction"
require 'pry'


def file_path file_name
  File.expand_path "../data/#{file_name}.json", __FILE__
end


transactions = TransactionParser.new file_path("transactions")
data = DataParser.new file_path("data")

# The user that made the most orders was __
data.parse!
transactions.parse!
# binding.pry
