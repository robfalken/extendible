require 'spec_helper'

describe Extendible do

  it 'responds to extendible' do
    expect(MyObjectSerializer.respond_to?(:extendible)).to be_true
  end

  it 'makes extendible objects available' do
    serializer = MyObjectSerializer.new({})
    MyObjectSerializer.extendible :entitled_ref, :poor_ref
    expect((serializer.respond_to?(:entitled_ref) and serializer.respond_to?(:poor_ref))).to be_true
  end

end
