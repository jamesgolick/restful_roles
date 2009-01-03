module RestfulRoles
  module ActiveRecord
    def self.included(receiver)
      receiver.class_eval do 
        extend  ClassMethods
        include InstanceMethods

        class_inheritable_accessor :permissions
        self.permissions = {}
      end
    end
    
    module ClassMethods
      def permits(action, &block)
        permissions[action] = block
      end

      def permits?(action, trustee)
        return false if permissions[action].nil?

        permissions[action].call(trustee)
      end
    end

    module InstanceMethods
      def permits?(action, trustee)
        return false if permissions[action].nil?

        permissions[action].call(trustee, self)
      end
    end
  end
end

