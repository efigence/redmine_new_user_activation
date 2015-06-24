require File.expand_path('../../test_helper', __FILE__)

class ActivatorTest < ActionMailer::TestCase

  def setup
    @user = User.new(:firstname => "new", :lastname => "user", :mail => "newuser@somenet.foo")
  end

  def test_cleaner_should_activate_account_with_current_activation_date
    @user.login = "new_user"
    @user.activation_date = Time.now+1.month
    @user.save
    assert_equal 4, @user.status

    RedmineNewUserActivation::Activator.activate_pending_users

    assert_equal 1, @user.status
    assert_emails 1
  end

end
