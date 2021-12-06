# frozen_string_literal: true

# ✅ show "Insert Coins" on display when no coins
# ✅ insert coin and display the balance
# understand which type of coin has been received
# return coin that does not match currency
# show "Insert more coins" if balance does not cover products price
# dispense product after button is clicked
# shows thank you message after the button is clicked
# returns change if extra balance after purchasing product
# show message "Change not available. Return money or purchase without change" if no coins remain in vending machine
# buyer can push a button to return money
# show message "Sold Out" if product does not exist

class VendingMachine
  def initialize
    @display = 'Insert Coins'
    @coins_values = []
  end

  attr_reader :display

  def insert_coin(coin)
    @coins_values << coin[:value]

    @display = @coins_values.sum
  end
end
