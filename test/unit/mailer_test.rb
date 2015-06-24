require File.expand_path('../../test_helper', __FILE__)

class MailerTest < ActionMailer::TestCase

  def setup
    @user = User.new(:firstname => "new", :lastname => "one", :mail => "newone@somenet.foo")
    @user.login ="new_one"
  end

  def test_should_send_account_information_for_active_user
    user1 = @user
    user1.save

    Mailer.account_information(user1, user1.password).deliver_now

    assert_emails 1
  end

  def test_should_not_send_account_information_for_pending_user
    user2 = @user
    user2.activation_date = Date.today+1.month
    user2.save

    Mailer.account_information(user2, user2.password).deliver_now

    assert_emails 0
  end

end
