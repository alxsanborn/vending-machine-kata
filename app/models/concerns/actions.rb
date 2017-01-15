module Actions

  module InsertedCoin
    def total
      ((dimes.length*0.1) + (nickels.length*0.05) + (quarters.length*0.25)).round(2)
    end
  end


  module ProductInstance
    def select_button
      self.selected = true
      self.save
    end

    def deselect_button
      self.selected = false
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
        [quarters, remainder.round(2)]
      end

  #     def make_change_dimes(remainder)
  #       while remainder >= 0.10
  #         remainder -= 0.10
  #         self.coin_return.dimes.push(Dime.create)
  #         if remainder < 0.10
  #           break
  #         end
  #       end
  #       remainder.round(2)
  #     end
  #
  #     def make_change_nickels
  #       self.coin_return.nickels.push(Nickel.create)
  #     end
  #
  #     def make_change(remainder)
  #       remainder = make_change_quarters(remainder)
  #       remainder = make_change_dimes(remainder)
  #       make_change_nickels if remainder && remainder > 0
  #       return {
  #         "quarters" => self.coin_return.quarters.length,
  #         "dimes" => self.coin_return.dimes.length,
  #         "nickels" => self.coin_return.nickels.length
  #       }
  #     end
  #
  #     def remainder?
  #       self.total - product_selected?.price
  #     end
   end

end
