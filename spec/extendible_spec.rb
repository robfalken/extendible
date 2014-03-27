require 'spec_helper'


class TestSerializer < ActiveModel::Serializer
  include Extendible
end


describe Extendible do
  it 'responds to extendible' do
    expect(TestSerializer.respond_to?(:extendible)).to be_true
  end

  it 'makes extendible objects available' do
    serializer = TestSerializer.new({})
    TestSerializer.extendible :ref_one, :ref_two
    expect((serializer.respond_to?(:ref_one) and serializer.respond_to?(:ref_two))).to be_true
  end
end
