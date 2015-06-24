require File.expand_path('../../test_helper', __FILE__)
require File.expand_path('../../../app/workers/users_activation_worker', __FILE__)
require 'sidekiq/testing'

class UserActivationWorkerTest < ActionMailer::TestCase
  fixtures :users

  def setup
    User.current = nil
  end

  def test_activator_should_activate_account_with_current_activation_date
    @user = User.create(:firstname => "new", :lastname => "user", :mail => "newuser@somenet.foo")
    @user.login = "new_user"
    @user.activation_date = Time.now
    @user.set_pending
    @user.save

    assert_difference 'User.status(User::STATUS_PENDING).count', -1 do
      RedmineNewUserActivation::UsersActivationWorker.perform_async
      RedmineNewUserActivation::UsersActivationWorker.drain
    end

    assert_emails 1
  end

end
