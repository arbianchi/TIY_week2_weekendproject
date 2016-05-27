

class Item

  attr_reader :name, :id, :price, :category

  def initialize id, name, price, category=nil
    @name = name
    @id = id
    @price = price
    @category = category

  end

end
