require_dependency 'user'

module RedmineNewUserActivation
  module Patches
    module UserPatch
      def self.included(base)
        base.class_eval do
          unloadable

          safe_attributes 'activation_date'

          validate :activation_date_cannot_be_in_the_past

          def activation_date_cannot_be_in_the_past
            errors.add(:activation_date, "can't be in the past") if
            !activation_date.blank? && activation_date < Date.today
          end

          def pending?
           self.status == STATUS_PENDING
         end

       end
     end
   end
 end
end

unless User.included_modules.include?(RedmineNewUserActivation::Patches::UserPatch)
  User.send(:include, RedmineNewUserActivation::Patches::UserPatch)
end
