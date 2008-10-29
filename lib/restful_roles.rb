require 'restful_roles/active_record'
require 'restful_roles/action_controller'

module RestfulRoles
  mattr_accessor :action_map, :class_deciding_actions
  self.action_map = HashWithIndifferentAccess.new({
    'new'     => :create,
    'edit'    => :update,
    'index'   => :list,
    'show'    => :show,
    'destroy' => :destroy
  })

  self.class_deciding_actions = [:create, :list]
  
  class << self
    def action_name_for(action)
      action_map[action] || action.to_sym
    end

    def class_decides?(action)
      class_deciding_actions.include?(action)
    end
  end
end

