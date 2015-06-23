require_dependency 'user'

module RedmineNewUserActivation
  module Patches
    module UserPatch
      def self.included(base)
        base.class_eval do
          unloadable

          safe_attributes 'activation_date'

          validate :activation_date_cannot_be_in_the_past
          validate :activation_date_can_be_modified_only_for_pending_status, :on => :update

          def activation_date_cannot_be_in_the_past
            errors.add(:activation_date, "should be later than today") if
            activation_date && activation_date <= Date.today
          end

          def activation_date_can_be_modified_only_for_pending_status
            errors.add(:activation_date, "can be modified only for users with pending status") if
            !(status == User::STATUS_PENDING) && activation_date
          end

          def pending?
            self.status == User::STATUS_PENDING
          end

          def set_pending
            self.status = User::STATUS_PENDING
          end

          def set_pending!
            update_attribute(:status, User::STATUS_PENDING)
          end
        end
      end

      CSS_CLASS_BY_STATUS = {
        User::STATUS_ANONYMOUS  => 'anon',
        User::STATUS_ACTIVE     => 'active',
        User::STATUS_REGISTERED => 'registered',
        User::STATUS_LOCKED     => 'locked',
        User::STATUS_PENDING    => 'pending'
      }

    end
  end
end

unless User.included_modules.include?(RedmineNewUserActivation::Patches::UserPatch)
  User.send(:include, RedmineNewUserActivation::Patches::UserPatch)
end
