module RestfulRoles
  module ActionController
    def self.included(receiver)
      receiver.class_eval do 
        extend  ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods
      protected
        def checks_permissions(*opts)
          before_filter :check_permissions, *opts
        end
    end

    module InstanceMethods
      protected
        def check_permissions
          action   = RestfulRoles.action_name_for(params[:action])
          receiver = RestfulRoles.class_decides?(action) ? model : object

          receiver.permits?(action, current_person)
        end
    end
  end
end

