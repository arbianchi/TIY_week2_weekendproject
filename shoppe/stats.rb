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

t = TransactionParser.new file_path("transactions")
d = DataParser.new file_path("data")

d.parse!
t.parse!

def find_frequent_buyer
  transaction_by_user = {}
  transaction_by_user.default = 0

  (t.transactions).each do |x|

    transaction_by_user[x.user_id] += 1
  end

  bigbuyer = transaction_by_user.select {|k,v| v == transaction_by_user.values.max }

  buyername = nil

  (d.users).each do |x|
    if x.id == 16
      buyername = x.name
    end
  end

  puts "The user that made the most orders was #{buyername}."
end

def ergo_lamps_sold

  lamps = 0
  itemid = nil

  d.items.each do |item|

    if item.name == "Ergonomic Rubber Lamp"
      itemid = item.id
    end
  end

  t.transactions.each do |x|
    if x.item_id == itemid
      lamps += x.quantity
    end
  end
  puts "We sold #{lamps} Ergonomic Rubber Lamps"
end

def sold_from_Tools
  tools = 0
  t.transactions.each do |x|
    d.items.each do |y|
      if (y.id == x.item_id) && (y.category.include?"Tools")
        tools += x.quantity
      end
    end
  end

  puts "We sold #{tools.count} items from the Tools category."
end


def total_revenue
  revenue = 0

  t.transactions.each do |x|
    d.items.each do |y|
      if x.item_id == y.id
        revenue += y.price * x.quantity
      end

    end
  end

  puts "Total revenue is: $#{revenue.round(2)}."
end

# * Harder: the highest grossing category was __

# list of categories
# for each transaction,
  #look at the category,
  #for each category, if it is contained in t.category, add price * quantity to it

categories = []
parsed_categories_revenue = {}
revenue_by_category = {}
revenue_by_category.default = 0


d.items.each do |x|
  categories.push(x.category)
end

categories.each do |x|
  if x.include? " & "
    x.delete! " & "
  end
end

categories = categories.join.split /(?=[A-Z])/
categories.each do |x|
  parsed_categories_revenue[x] = 0
end


  t.transactions.each do |x|
    parsed_categories_revenue.each do |key,value|
    d.items.each do |y|
      if (x.item_id == y.id) && (y.category.include? key)
        parsed_categories_revenue[key] += (y.price * x.quantity)
      end

    end

    end
  end

  highest_cat = parsed_categories_revenue.key(parsed_categories_revenue.values.max)

puts "The highest grossing category is #{highest_cat}."

# binding.pry
