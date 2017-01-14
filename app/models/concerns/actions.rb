module Actions

  module InsertedCoin
    def total
      ((dimes.length*0.1) + (nickels.length*0.05) + (quarters.length*0.25)).round(2)
    end
  end

  module Products
    def product_selected?
      Product.all.select{|product| product.selected == true}.first
    end

    def select_button
      self.selected = true
      self.save
    end

    def deselect_button
      self.selected = false
      self.save
    end
  end

end
