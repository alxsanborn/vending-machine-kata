module UserMessages
  def insert_coins
    "INSERT COINS"
  end

  def user_message
    case self.total
      when 0
        insert_coins
      else
        self.value = self.total
        self.value
    end
  end
end
