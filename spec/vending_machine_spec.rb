# frozen_string_literal: true

require 'spec_helper.rb'
require 'vending_machine'

describe VendingMachine do
  describe '#insert_coin' do
    it 'displays insert coin message' do
      expect(subject.display).to eq('Insert Coins')
    end

    context 'when a coin is inserted' do
      context 'when nickel' do
        it 'display value of the coin' do
          subject.insert_coin(VendingMachine::COINS_VALUES[:nickel])

          expect(subject.display).to eq(5)
        end
      end

      context 'when dime' do
        it 'display value of the coin' do
          subject.insert_coin(VendingMachine::COINS_VALUES[:dime])

          expect(subject.display).to eq(10)
        end
      end

      context 'when quarter' do
        it 'display value of the coin' do
          subject.insert_coin(VendingMachine::COINS_VALUES[:quarter])

          expect(subject.display).to eq(25)
        end
      end
    end

    context 'when a multiple coins are inserted' do
      it 'display sum value of inserted coins' do
        coin_value1 = VendingMachine::COINS_VALUES[:nickel]
        coin_value2 = VendingMachine::COINS_VALUES[:dime]
        coin_value3 = VendingMachine::COINS_VALUES[:quarter]

        subject.insert_coin(coin_value1)
        subject.insert_coin(coin_value2)
        subject.insert_coin(coin_value3)

        expect(subject.display).to eq(40)
      end
    end

    context 'when coin is not valid' do
      it 'return the coin' do
        subject.insert_coin(7)

        expect(subject.display).to eq('Return coin. Balance: 0')
      end

      it 'not change coins balance sum' do
        nickel_coin_value = VendingMachine::COINS_VALUES[:nickel]

        subject.insert_coin(nickel_coin_value)
        subject.insert_coin(7)

        expect(subject.display).to eq("Return coin. Balance: #{nickel_coin_value}")
      end
    end
  end

  describe '#product_button' do
    it 'show thank you message' do
      2.times do
        subject.insert_coin(VendingMachine::COINS_VALUES[:quarter])
      end

      expect(subject.display).to eq(50)
      subject.product_button('chips')

      expect(subject.display).to eq('Thank you. Here is your chips')
    end

    it 'dispence product' do
      name = 'chips'
      product = instance_double('Product', name: name, price: 50)

      allow(product).to receive(:dispense).and_return(name)

      2.times do
        subject.insert_coin(VendingMachine::COINS_VALUES[:quarter])
      end

      expect(subject.display).to eq(50)
      expect(subject.product_button(name)).to eq(name)
    end

    it 'reset coins values after dispense product' do
      3.times do
        subject.insert_coin(VendingMachine::COINS_VALUES[:quarter])
      end

      expect(subject.display).to eq(75)

      subject.product_button('chips')

      expect(subject.coins_values.sum).to eq(25)
    end

    it 'reset display after dispense product' do
      3.times do
        subject.insert_coin(VendingMachine::COINS_VALUES[:quarter])
      end

      expect(subject.display).to eq(75)

      subject.product_button('chips')

      expect(subject.display).to eq('Thank you. Here is your chips')
      expect(subject.display).to eq(25)
    end

    context 'when 0 coins' do
      it 'returns Insert more coins' do
        subject.product_button('chips')

        expect(subject.display).to eq('Insert more coins!')
      end
    end

    context 'when not enought coins' do
      it 'returns Insert more coins' do
        subject.insert_coin(VendingMachine::COINS_VALUES[:quarter])
        subject.product_button('chips')

        expect(subject.display).to eq('Insert more coins!')
      end
    end
  end

  describe '#return_coins' do
    context 'when 0 coins' do
      it 'return message You have no balance to return' do
        subject.return_coins

        expect(subject.display).to eq('You have no balance to return')
      end
    end

    it 'return inserted coins value' do
      subject.insert_coin(VendingMachine::COINS_VALUES[:nickel])
      subject.insert_coin(VendingMachine::COINS_VALUES[:dime])

      expect(subject.display).to eq(15)

      subject.return_coins

      expect(subject.display).to eq('Returning 15 coins')
      expect(subject.display).to eq('Insert Coins')
    end

    it 'decrease coins values to 0' do
      subject.insert_coin(VendingMachine::COINS_VALUES[:nickel])
      subject.insert_coin(VendingMachine::COINS_VALUES[:dime])

      expect(subject.display).to eq(15)

      subject.return_coins

      expect(subject.coins_values.sum).to eq(0)
    end

    it 'return real coins from the sum' do
      subject.insert_coin(VendingMachine::COINS_VALUES[:quarter])
      subject.insert_coin(VendingMachine::COINS_VALUES[:dime])
      subject.insert_coin(VendingMachine::COINS_VALUES[:nickel])
      subject.insert_coin(VendingMachine::COINS_VALUES[:nickel])

      expect(subject.display).to eq(45)

      expect(subject.return_coins).to eq([{ dime: 2, nickel: 0, quarter: 1 }])
    end
  end
end
