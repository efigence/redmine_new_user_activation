#### PLACE IT IN REDMINE ROOT DIRECTORY ####

require "clockwork"

module Clockwork
  every(1.day, 'users_activation.perform', :at => '03:00') do
    RedmineNewUserActivation::UsersActivationWorker.perform_async
  end
end
