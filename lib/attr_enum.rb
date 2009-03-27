
# TODO: add rdoc
module AttrEnum
  def self.included(base)
    base.send :extend, ClassMethods 
  end
  
  module ClassMethods 
    def attr_enum(type_name, valid_types)
      # Create a class constant
      const_set(:"#{type_name.to_s.upcase}_TYPES", valid_types)
        
      class_eval do
        # Create getter, type is stored as an integer in the db
        define_method(:"#{type_name}") do
          index = read_attribute(type_name)
          types = self.class.const_get :"#{type_name.to_s.upcase}_TYPES"
          types[index] unless index.nil?
        end
        
        # Create setter with type constraint
        define_method(:"#{type_name}=") do |type|
          if self.class.const_get(:"#{type_name.to_s.upcase}_TYPES").include?(type)
            write_attribute :"#{type_name}", self.class.const_get(:"#{type_name.to_s.upcase}_TYPES").index(type)
          else
            raise TypeError, "Must be one of #{self.class.const_get(:"#{type_name.to_s.upcase}_TYPES").join ', ' }."
          end
        end
      end
      
      self
    end
  end
end

ActiveRecord::Base.send :include, AttrEnum
