

class Transaction

  attr_reader :timestamp, :user_id, :item_id, :quantity

  def initialize timestamp, user_id, item_id, quantity

    @timestamp, @user_id, @item_id,@quantity = timestamp, user_id, item_id, quantity

  end

end
