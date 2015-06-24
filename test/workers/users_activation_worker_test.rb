require File.expand_path('../../test_helper', __FILE__)
require File.expand_path('../../../app/workers/users_activation_worker', __FILE__)
require 'sidekiq/testing'

class UserActivationWorkerTest < ActionMailer::TestCase
  fixtures :users

  def setup
    User.current = nil
  end

  def test_activator_should_activate_account_with_current_activation_date
    user1 = users(:users_001)
    user1.save
    assert_equal 4, user1.status

    RedmineNewUserActivation::UsersActivationWorker.perform_async
    RedmineNewUserActivation::UsersActivationWorker.drain

    assert_equal 1, user1.status
    assert_emails 1
  end

end
