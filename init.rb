require 'restful_roles'

ActiveRecord::Base.send(:include, RestfulRoles::ActiveRecord)
ActionController::Base.send(:include, RestfulRoles::ActionController)

