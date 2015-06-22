require_dependency 'principal'

module RedmineNewUserActivation
  module Patches
    module PrincipalPatch
      def self.included(base)
        base.class_eval do
          unloadable

          STATUS_PENDING = 4

        end
      end
    end
  end
end

unless Principal.included_modules.include?(RedmineNewUserActivation::Patches::PrincipalPatch)
  Principal.send(:include, RedmineNewUserActivation::Patches::PrincipalPatch)
end
