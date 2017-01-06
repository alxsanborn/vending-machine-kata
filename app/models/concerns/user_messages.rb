module UserMessages
  def insert_coins
    "INSERT COINS"
  end

  def dispense_item
    "THANK YOU"
  end

  def user_message(product = nil)
    case
    when self.total == 0
        insert_coins
    when product != nil && self.total == product.price && product.selected == true
      dispense_item
      else
        self.value = self.total
        self.value
    end
  end
end
