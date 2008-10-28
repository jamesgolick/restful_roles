require 'restful_roles'

ActiveRecord::Base.send(:include, RestfulRoles::ActiveRecord)

