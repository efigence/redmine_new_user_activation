require_dependency 'user'

module RedmineNewUserActivation
  module Patches
    module UsersHelperPatch
      def self.included(base)
        base.class_eval do
          unloadable

          def users_status_options_for_select(selected)
            user_count_by_status = User.group('status').count.to_hash
            options_for_select([[l(:label_all), ''],
              ["#{l(:status_active)} (#{user_count_by_status[1].to_i})", '1'],
              ["#{l(:status_registered)} (#{user_count_by_status[2].to_i})", '2'],
              ["#{l(:status_locked)} (#{user_count_by_status[3].to_i})", '3'],
              ["#{l(:status_pending)} (#{user_count_by_status[4].to_i})", '4']], selected.to_s)
          end

        end
      end
    end
  end
end

unless UsersHelper.included_modules.include?(RedmineNewUserActivation::Patches::UsersHelperPatch)
  UsersHelper.send(:include, RedmineNewUserActivation::Patches::UsersHelperPatch)
end
