# frozen_string_literal: true

# ✅ show "Insert Coins" on display when no coins
# ✅ insert coin and display the balance
# ✅ understand which type of coin has been received
# ✅ return coin that does not match currency
# ✅ show "Insert more coins" if balance does not cover products price
# ✅ dispense product after button is clicked
# ✅ shows thank you message after the button is clicked
# ✅ reset coins and display after dispense product
#    - maybe diplay Insert coin if 0 coins after dispense
# buyer can push a button to return money
# returns change if extra balance after purchasing product
#    - return change coin by coin from sum of the coins values array
# show message "Change not available. Return money or purchase without change" if no coins remain in vending machine
# show message "Sold Out" if product does not exist

require_relative 'product'

class VendingMachine
  COINS_VALUES = { nickel: 5, dime: 10, quarter: 25 }.freeze
  VM_PRODUCTS = [Product.new('chips', 50),
                 Product.new('cola', 100),
                 Product.new('candy', 65)].freeze

  attr_reader :coins_values

  def initialize
    @display = 'Insert Coins'
    @coins_values = []
    @reset_state = false
  end

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

    return setup_display('Insert more coins!') if coins_sum < product.price

    setup_display("Thank you. Here is your #{product.name}")
    reset_coins_values(product.price)
    product.dispense
  end

  def display
    setup_display(coins_sum) if @reset_state

    @reset_state = true if @display.to_s.include?('Thank you')

    @display
  end

  private

  def coins_sum
    @coins_values.sum
  end

  def setup_display(content)
    @display = content
  end

  def reset_coins_values(product_price)
    value = coins_sum - product_price

    @coins_values = [value]
  end
end
