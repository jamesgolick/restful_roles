module RestfulRoles
  module ActionController
    def self.included(receiver)
      receiver.class_eval do 
        extend  ClassMethods
      end
    end

    module ClassMethods
      protected
        def checks_permissions(*opts)
          before_filter :check_permissions, *opts
        end
    end
  end
end

