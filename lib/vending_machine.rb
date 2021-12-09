# frozen_string_literal: true

# ✅ show "Insert Coins" on display when no coins
# ✅ insert coin and display the balance
# ✅ understand which type of coin has been received
# ✅ return coin that does not match currency
# ✅ show "Insert more coins" if balance does not cover products price
# dispense product after button is clicked
# shows thank you message after the button is clicked
# returns change if extra balance after purchasing product
# show message "Change not available. Return money or purchase without change" if no coins remain in vending machine
# buyer can push a button to return money
# show message "Sold Out" if product does not exist

require_relative 'product'

class VendingMachine
  COINS_VALUES = { nickel: 5, dime: 10, quarter: 25 }.freeze
  VM_PRODUCTS = [Product.new('chips', 50),
                 Product.new('cola', 100),
                 Product.new('candy', 65)].freeze

  def initialize
    @display = 'Insert Coins'
    @coins_values = []
  end

  attr_reader :display

  def insert_coin(coin)
    if COINS_VALUES.values.include?(coin)
      @coins_values << coin

      setup_display(coins_sum)
    else
      setup_display("Return coin. Balance: #{coins_sum}")
    end
  end

  def product_button(product_name)
    product = VM_PRODUCTS.select { |p| p.name == product_name }.first

    setup_display('Insert more coins!') if coins_sum < product.price

    product.dispense
  end

  private

  def coins_sum
    @coins_values.sum
  end

  def setup_display(content)
    @display = content
  end

  def dispence(product)
    product.name
  end
end
