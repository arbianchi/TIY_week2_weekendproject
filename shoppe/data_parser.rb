require "json"



class DataParser

attr_reader :users, :path, :items, :data

def file_path file_name
  File.expand_path "../data/#{file_name}.json", __FILE__
end

  def initialize path
    @users = []
    @path = path
    @items = []
    @data = JSON.parse(File.read path)
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
