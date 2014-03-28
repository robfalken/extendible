class Reference
  attr_accessor :title, :description, :secret

  def initialize
    @title = 'I\'m an object'
    @description = 'Just a description'
    @secret = 'this is secret'
  end

  def as_json
    {
      title: @title,
      description: @description,
      secret: @secret
    }
  end
end

class EntitledRef < Reference
end

class PoorRef < Reference
end

class MyObject
  attr_accessor :entitled_ref, :poor_ref

  def initialize
    @entitled_ref = EntitledRef.new
    @poor_ref = PoorRef.new
  end
end

class MyObjectSerializer < ActiveModel::Serializer
  include Extendible
end

class EntitledRefSerializer < ActiveModel::Serializer
  include Extendible
  attributes :title, :description
end
