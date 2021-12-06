# frozen_string_literal: true

require 'spec_helper.rb'
require 'vending_machine'

describe VendingMachine do
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
  end

  context 'when a multiple coins are inserted' do
    it 'display sum value of inserted coins' do
      coin_value1 = VendingMachine::COINS_VALUES[:nickel]
      coin_value2 = VendingMachine::COINS_VALUES[:dime]
      coin_value3 = 25

      subject.insert_coin(coin_value1)
      subject.insert_coin(coin_value2)
      subject.insert_coin(coin_value3)

      expect(subject.display).to eq(40)
    end
  end
end
