require_dependency 'user'

module RedmineNewUserActivation
  module Patches
    module AccountControllerPatch
      def self.included(base)
        base.class_eval do
          unloadable

          # before_save :set_initial_status

          # def set_initial_status
          #   if @user.activation_date
          #     @user.set_pending
          #   else
          #     @user.activate
          #   end
          # end

        end
      end
    end
  end
end

unless AccountController.included_modules.include?(RedmineNewUserActivation::Patches::AccountControllerPatch)
  AccountController.send(:include, RedmineNewUserActivation::Patches::AccountControllerPatch)
end
