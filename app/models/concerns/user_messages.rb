module UserMessages
  def insert_coins
    "INSERT COINS"
  end

  def dispense_item
    "THANK YOU"
  end

  def product_selected?
    Product.all.select{|product| product.selected == true}
  end

  def reset_dimes_amount
    self.dimes.delete_all
  end

  def reset_nickels_amount
    self.nickels.delete_all
  end

  def user_message
    case
    when self.total == 0
      insert_coins
    when product_selected?[0] && self.total == product_selected?[0].price
      reset_dimes_amount
      reset_nickels_amount
      dispense_item
      else
        self.value = self.total
        self.value
    end
  end
end
