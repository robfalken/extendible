class Reference
  include ActiveModel::Model
  attr_accessor :id, :title, :description, :secret
end

class EntitledRef < Reference
end

class PoorRef < Reference
end

class MyObject
  include ActiveModel::Model
  attr_accessor :entitled_ref, :poor_ref

  def initialize
    @entitled_ref = EntitledRef.new(id: 1, title: 'I\'m entitled', description: 'Just a description', secret: 'super secret')
    @poor_ref = PoorRef.new(id: 2, title: 'I\'m poor', description: 'Just a description', secret: 'super secret')
  end
end

class MyObjectSerializer < ActiveModel::Serializer
  include Extendible
  extendible :entitled_ref, :poor_ref
end

class EntitledRefSerializer < ActiveModel::Serializer
  include Extendible
  attributes :title, :description
  extendible :entitled_ref, :poor_ref
end
