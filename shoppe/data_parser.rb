require 'JSON'

require "./item"
require "./user"
require "./data_parser"
require "./transaction_parser"

class DataParser

attr_reader :users, :path, :items

  def initialize path
    @users = []
    @path = path
    @data = JSON.parse File.read path
    @items = []
  end

  def parse!

    @data["users"].each do |x|
      @users.push (User.new x.values[0],x.values[1],x.values[2] )
    end

    @data["items"].each do |x|
      @items.push (Item.new x.values[0],x.values[1],x.values[2] )
    end

  end

end
