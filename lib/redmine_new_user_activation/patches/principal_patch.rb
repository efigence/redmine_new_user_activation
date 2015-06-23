require_dependency 'principal'

module RedmineNewUserActivation
  module Patches
    module PrincipalPatch

      STATUS_PENDING = 4

    end
  end
end

unless Principal.included_modules.include?(RedmineNewUserActivation::Patches::PrincipalPatch)
  Principal.send(:include, RedmineNewUserActivation::Patches::PrincipalPatch)
end
