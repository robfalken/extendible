module Extendible

  def self.included(base)
    base.class_eval { extend ClassMethods }
  end

  def extended_objects
    return @extended_objects unless @extended_objects.nil?
    # empty array if no params[:extend] is provided
    return [] if scope[:extend].nil?
    all = {}
    # iterate comma separated list of objects to extend
    scope[:extend].split(',').map(&:strip).each do |object_name|
      if object_name.include?('.') # dot found, split into object and attribute
        obj, attr = object_name.split('.')
        if all.has_key?(obj.to_sym) # object already has attributes specified, add attribute to array
          all[obj.to_sym] << attr
        else # first attribute for array, initialize array with attribute
          all[obj.to_sym] = [attr]
        end
      else # no dot (.) found, extend with all attributes
        all[object_name.to_sym] = nil
      end
    end

    @extended_objects = all
  end

  module ClassMethods
    def extendible(*children)
      # iterate through all obects that are supposed to be extendible
      children.each do |child_sym|
        attributes child_sym
        define_method child_sym do
          # nil if child is nonexistent
          return nil if object.try(child_sym).nil?
          if extended_objects.has_key?(child_sym) # params[:extend] includes child, extend attributes
            if extended_objects[child_sym].nil? # no attributes are specified, extend with all
              object.try(child_sym)
            else # only extend with attributes provided with dot notation
              object.try(child_sym).attributes.extract!(*extended_objects[child_sym].map(&:to_s))
            end
          else # child is not in params[:extend], only include id
            object.try(child_sym).attributes.extract!('id')
          end
        end
      end
    end
  end

end