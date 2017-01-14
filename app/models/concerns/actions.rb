module Actions

  module InsertedCoin
    def total
      ((dimes.length*0.1) + (nickels.length*0.05) + (quarters.length*0.25)).round(2)
    end
  end

end
