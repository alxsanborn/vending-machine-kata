module Actions

  module InsertedCoins
    def total
      ((dimes*0.1) + (nickels*0.05) + (quarters*0.25)).round(2)
    end
  end

  module ProductInstance
    def select_button
      self.selected = true if Product.product_selected? == nil
      self.save
    end

    def deselect_button
      self.selected = false
      self.save
    end

    def decrease_product_quantity
      self.quantity -= 1
      self.save
    end
  end

  module ProductClass
    def product_selected?
      Product.all.select{|product| product.selected == true}.first
    end
  end

  module ChangeReturn
    def make_change_quarters(remainder)
      quarters = 0
        while remainder >= 0.25
          remainder -= 0.25
          quarters += 1
          if remainder < 0.25
            break
          end
        end
        InsertedCoin.machine_quarters -= quarters
        [quarters, remainder.round(2)]
      end

      def make_change_dimes(remainder)
        dimes = 0
        while remainder >= 0.10
          remainder -= 0.10
          dimes += 1
          if remainder < 0.10
            break
          end
        end
        InsertedCoin.machine_dimes -= dimes
        [dimes, remainder.round(2)]
      end

      def make_change_nickels(remainder)
        if remainder > 0
          InsertedCoin.machine_nickels -= 1
          1
        else 0
        end
      end

      def make_change(remainder)
        quarters = make_change_quarters(remainder)
        remainder = quarters[1]

        dimes = make_change_dimes(remainder)
        remainder = dimes[1]

        nickels = make_change_nickels(remainder)

        "Quarters - #{quarters[0]}; Dimes - #{dimes[0]}; Nickels - #{nickels}"
      end

      def remainder?(product)
        inserted_coin.total - product.price
      end
   end

end
