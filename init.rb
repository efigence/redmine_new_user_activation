Redmine::Plugin.register :redmine_new_user_activation do
  name 'Redmine New User Activation plugin'
  author 'Maria Syczewska'
  description 'This is a plugin for Redmine for implementing and managing user activation date'
  version '0.0.2'
  url 'https://github.com/efigence/redmine_new_user_activation'
  author_url 'https://github.com/efigence'

  settings :default => {'account_activated' => ""}, :partial => 'settings/account_activated_settings'
  settings :default => {'email_domains' => ""}, :partial => 'settings/account_activated_settings'

  ActionDispatch::Callbacks.to_prepare do
    require 'redmine_new_user_activation/hooks/activation_date'
    require 'redmine_new_user_activation/patches/mailer_patch'
    require 'redmine_new_user_activation/patches/principal_patch'
    require 'redmine_new_user_activation/patches/users_helper_patch'
    require 'redmine_new_user_activation/patches/user_patch'
  end
end
