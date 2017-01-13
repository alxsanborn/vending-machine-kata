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
    dimes.delete_all
  end

  def reset_nickels_amount
    nickels.delete_all
  end

  def reset_quarters_amount
    quarters.delete_all
  end

  def make_change_quarters(remainder)
    quarters = 0
    while remainder >= 0.25
        remainder -= 0.25
        quarters += 1
      if remainder < 0.25
        break
      end
    end
    quarters
  end

  def user_message
    case
    when self.total == 0
      insert_coins
    when product_selected?[0] && self.total == product_selected?[0].price
      reset_dimes_amount
      reset_nickels_amount
      reset_quarters_amount
      return dispense_item
      return user_message
      else
        value_will_change!
        self.value = self.total
        self.value
    end
  end
end
