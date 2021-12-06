# frozen_string_literal: true

require 'spec_helper.rb'
require 'product'

describe Product do
  subject { described_class.new('cola', 100) }

  it 'should have a name' do
    expect(subject.name).to eq 'cola'
  end

  it 'should have a price' do
    expect(subject.price).to eq 100
  end
end
