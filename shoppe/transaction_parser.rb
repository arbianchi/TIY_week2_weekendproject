require "./item"
require "./user"
require "./data_parser"
require "./transaction_parser"

class TransactionParser

  attr_reader :path, :data, :transaction

  def initialize path
    @transaction = []
    @path = path
    @data = JSON.parse File.read path
  end

  def parse!

    @data.each do |x|
      @transaction.push x
    end
  end

end
