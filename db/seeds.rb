# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all
Order.destroy_all
Coin.destroy_all

cola = Product.create(name: "Cola", price: 1.00, quantity: 30, product_image: File.new("app/assets/images/cola.jpeg"))
chips = Product.create(name: "Chips", price: 0.50, product_image:  File.new("app/assets/images/chips.png"))
candy = Product.create(name: "Candy", price: 0.65, quantity: 5, product_image: File.new("app/assets/images/candy.jpg"))

order = Order.create

quarter_1 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671, coin_image: File.new("app/assets/images/quarter.png"))
quarter_2 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671, coin_image: File.new("app/assets/images/quarter.png"))
quarter_3 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671, coin_image: File.new("app/assets/images/quarter.png"))
quarter_4 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671, coin_image: File.new("app/assets/images/quarter.png"))

dime_1 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053, coin_image: File.new("app/assets/images/dime.png"))
dime_2 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053, coin_image: File.new("app/assets/images/dime.png"))
dime_3 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053, coin_image: File.new("app/assets/images/dime.png"))
dime_4 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053, coin_image: File.new("app/assets/images/dime.png"))
dime_5 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053, coin_image: File.new("app/assets/images/dime.png"))
dime_6 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053, coin_image: File.new("app/assets/images/dime.png"))

nickel_1 = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625, coin_image: File.new("app/assets/images/nickel.png"))
nickel_2 = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625, coin_image: File.new("app/assets/images/nickel.png"))
nickel_3 = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625, coin_image: File.new("app/assets/images/nickel.png"))
nickel_4 = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625, coin_image: File.new("app/assets/images/nickel.png"))
nickel_5 = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625, coin_image: File.new("app/assets/images/nickel.png"))
nickel_6 = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625, coin_image: File.new("app/assets/images/nickel.png"))
penny = Coin.create(diameter: 0.751, weight: 2.500, thickness: 0.0598, coin_image: File.new("app/assets/images/penny.png"))
