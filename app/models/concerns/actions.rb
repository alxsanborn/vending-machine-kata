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
  end

end
