require File.expand_path('../../test_helper', __FILE__)

class ActivatorTest < ActionMailer::TestCase

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
      RedmineNewUserActivation::Activator.activate_pending_users
    end

    assert_emails 1
  end

end
