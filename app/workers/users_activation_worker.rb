module RedmineNewUserActivation
  class UsersActivationWorker
    include Sidekiq::Worker

    def perform
      RedmineNewUserActivation::Activator.activate_pending_users
    end

  end
end
