require_dependency 'user'

module RedmineNewUserActivation
  module Patches
    module UserPatch
      def self.included(base)
        base.class_eval do
          unloadable

          safe_attributes 'activation_date'

        end
      end
    end
  end
end

unless User.included_modules.include?(RedmineNewUserActivation::Patches::UserPatch)
  User.send(:include, RedmineNewUserActivation::Patches::UserPatch)
end
