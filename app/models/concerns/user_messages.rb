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
    while remainder >= 0.25
      remainder -= 0.25
      self.coin_return.quarters.push(Quarter.create)
      if remainder < 0.25
        break
      end
    end
    remainder.round(2)
  end

  def make_change_dimes(remainder)
    while remainder >= 0.10
      remainder -= 0.10
      @change["dimes"] += 1
      if remainder < 0.10
        break
      end
    end
    remainder.round(2)
  end

  def make_change_nickels
    @change["nickels"] += 1
  end

  def make_change(remainder)
    @change = {
      "quarters" => 0,
      "nickels" => 0,
      "dimes" => 0
    }
    remainder = make_change_quarters(remainder)
    remainder = make_change_dimes(remainder)
    make_change_nickels if remainder && remainder > 0
    @change
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
