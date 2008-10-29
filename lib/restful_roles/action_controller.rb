module RestfulRoles
  module ActionController
    def self.included(receiver)
      receiver.class_eval do 
        extend  ClassMethods
        include InstanceMethods

        class_inheritable_accessor :restful_roles_options
        self.restful_roles_options = { :trustee => :current_user }
      end
    end

    module ClassMethods
      protected
        def checks_permissions(opts = {})
          restful_roles_options[:trustee] = opts.delete(:trustee) if opts.has_key?(:trustee)

          before_filter :check_permissions, opts
        end
    end

    module InstanceMethods
      protected
        def check_permissions
          action   = RestfulRoles.action_name_for(params[:action])
          receiver = RestfulRoles.class_decides?(action) ? model : object

          receiver.permits?(action, send(restful_roles_options[:trustee]))
        end
    end
  end
end

