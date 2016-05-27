require "json"

class TransactionParser


  attr_reader :path, :transaction

  def initialize path
    @transaction = []
    @path = path
    @data = JSON.parse(File.read path)
  end

  def parse!

    @data.each do |x|
      # binding.pry
      @transaction.push (Transaction.new x.values[0],x.values[1],x.values[2], x.values[3] )
    end
  end

end
