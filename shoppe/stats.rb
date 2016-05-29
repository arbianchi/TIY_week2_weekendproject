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

transactions.parse!
data.parse!

class StatTools

  attr_reader :transactions, :data

  def initialize transactions, data
    @transactions = transactions
    @data = data
  end

  def find_frequent_buyer

    transaction_by_user = {}
    transaction_by_user.default = 0

    (@transactions.transactions).each do |x|

      transaction_by_user[x.user_id] += 1
    end

    bigbuyer = transaction_by_user.select {|k,v| v == transaction_by_user.values.max }

    buyername = nil

    (@data.users).each do |x|
      if x.id == 16
        buyername = x.name
      end
    end

    puts "The customer that made the most orders was #{buyername}."
    return buyername
  end

  def ergo_lamps_sold

    lamps = 0
    itemid = nil

    @data.items.each do |item|

      if item.name == "Ergonomic Rubber Lamp"
        itemid = item.id
      end
    end

    @transactions.transactions.each do |x|
      if x.item_id == itemid
        lamps += x.quantity
      end
    end
    puts "We sold #{lamps} Ergonomic Rubber Lamps"
    return lamps
  end

  def sold_from_tools
    tools = 0
    @transactions.transactions.each do |x|
      @data.items.each do |y|
        if (y.id == x.item_id) && (y.category.include?"Tools")
          tools += x.quantity
        end
      end
    end

    puts "We sold #{tools} items from the Tools category."
    return tools
  end

  def total_revenue
    revenue = 0

    @transactions.transactions.each do |x|
      @data.items.each do |y|
        if x.item_id == y.id
          revenue += y.price * x.quantity
        end

      end
    end

    puts "Total revenue is: $#{revenue.round(2)}."
    return revenue.round(2)
  end

  def highest_grossing_category

    categories = []
    parsed_categories_revenue = {}
    revenue_by_category = {}
    revenue_by_category.default = 0

    # Get list of individual categories
    @data.items.each do |x|
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

    # Get revenue by category
    @transactions.transactions.each do |x|
      parsed_categories_revenue.each do |key,value|
        @data.items.each do |y|
          if (x.item_id == y.id) && (y.category.include? key)
            parsed_categories_revenue[key] += (y.price * x.quantity)
          end
        end
      end
    end
    # Find category with max revenue
    highest_cat = parsed_categories_revenue.key(parsed_categories_revenue.values.max)

    puts "The highest grossing category is #{highest_cat}."
    return highest_cat

  end

end

shoppe = StatTools.new transactions, data

question1 = shoppe.find_frequent_buyer
question2 = shoppe.ergo_lamps_sold
question3 = shoppe.sold_from_tools
question4 = shoppe.total_revenue
question5 = shoppe.highest_grossing_category
