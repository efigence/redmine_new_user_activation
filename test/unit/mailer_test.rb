require File.expand_path('../../test_helper', __FILE__)

class MailerTest < ActionMailer::TestCase

  def setup
    @user1 = User.new(:firstname => "new", :lastname => "one", :mail => "newone@somenet.foo")
    @user2 = User.new(:firstname => "new", :lastname => "user", :mail => "newuser@somenet.foo")
  end

  def test_should_send_account_information_for_active_user
      user1 = @user1
      user1.login = "new_one"
      user1.password = "user1234"
      user1.save

      Mailer.account_information(user1, "user1234").deliver_now

      assert_emails 1
  end

  def test_should_not_send_account_information_for_pending_user
      user2 = @user2
      user2.login = "new_user"
      user2.password = "user1234"
      user2.activation_date = Time.now+1.month
      user2.save

      Mailer.account_information(user2, "user1234").deliver_now

      assert_emails 0
  end

end
