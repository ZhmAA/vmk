# frozen_string_literal: true

require 'spec_helper.rb'
require 'vending_machine'

describe VendingMachine do
  it 'displays insert coin message' do
    expect(subject.display).to eq('Insert Coins')
  end

  context 'when a coin is inserted' do
    it 'display value of the coin' do
      coin = { value: 10 }

      subject.insert_coin(coin)

      expect(subject.display).to eq(coin[:value])
    end
  end

  context 'when a multiple coins are inserted' do
    it 'display sum value of inserted coins' do
      coin1 = { value: 5 }
      coin2 = { value: 10 }
      coin3 = { value: 25 }

      subject.insert_coin(coin1)
      subject.insert_coin(coin2)
      subject.insert_coin(coin3)

      expect(subject.display).to eq(40)
    end
  end
end
