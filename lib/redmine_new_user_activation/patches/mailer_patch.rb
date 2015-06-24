module RedmineNewUserActivation
  module Patches
    module MailerPatch
      def self.included(base)
        base.class_eval do
          unloadable

          def account_information(user, password)
            if user.active?
              set_language_if_valid user.language
              @user = user
              @password = password
              @login_url = url_for(:controller => 'account', :action => 'login')
              mail :to => user.mail,
              :subject => l(:mail_subject_register, Setting.app_title)
            end
          end

        end
      end
    end
  end
end

unless Mailer.included_modules.include?(RedmineNewUserActivation::Patches::MailerPatch)
  Mailer.send(:include, RedmineNewUserActivation::Patches::MailerPatch)
end

