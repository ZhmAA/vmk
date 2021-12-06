# frozen_string_literal: true

require 'spec_helper.rb'
require 'vending_machine'

describe VendingMachine do
  it 'displays insert coin message' do
    expect(subject.display).to eq('Insert Coins')
  end

  context 'when a coin is inserted' do
    it 'display value of the coin' do
      coin_value = 10

      subject.insert_coin(coin_value)

      expect(subject.display).to eq(coin_value)
    end
  end

  context 'when a multiple coins are inserted' do
    it 'display sum value of inserted coins' do
      coin_value1 = 5
      coin_value2 = 10
      coin_value3 = 25

      subject.insert_coin(coin_value1)
      subject.insert_coin(coin_value2)
      subject.insert_coin(coin_value3)

      expect(subject.display).to eq(40)
    end
  end
end
