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
  purchases = {}
  purchases.default = 0
  wanteditem = 0

  (t.transactions).each do |x|

    purchases[x.item_id] += x.quantity
  end

  d.items.each do |x|
    if x.name == "Ergonomic Rubber Lamp"
      wanteditem = x.id
    end
  end

  puts "We sold #{purchases[wanteditem]} Ergonomic Rubber Lamps"
end

def sold_from_Tools
  tools = []
  d.items.each do |x|
    if x.category == "Tools"

      tools.push(x)
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

  puts "Total revenue is: $#{revenue}."
end

* Harder: the highest grossing category was __
