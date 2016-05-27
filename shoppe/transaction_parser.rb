require "json"

class TransactionParser


  attr_reader :path, :transactions

  def initialize path
    @transactions = []
    @path = path
    @data = JSON.parse(File.read path)
  end

  def parse!

    @data.each do |x|
      # binding.pry
      @transactions.push (Transaction.new x.values[0],x.values[1],x.values[2], x.values[3] )
    end
    @transactions
  end

end
