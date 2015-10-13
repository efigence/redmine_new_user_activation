require File.expand_path('../../test_helper', __FILE__)

class MailerTest < ActionMailer::TestCase

  def setup
    @user = User.new(:firstname => "new", :lastname => "one", :mail => "newone@somenet.foo")
    @user.login ="new_one"
    Setting.plugin_redmine_new_user_activation['account_information'] = "This is additional text for testing"
  end

  def test_should_send_account_information_for_active_user
    user = @user
    user.save

    Mailer.account_information(user, user.password).deliver_now

    assert_emails 1
  end

  def test_should_not_send_account_information_for_pending_user
    user = @user
    user.activation_date = Date.today+1.month
    user.save

    Mailer.account_information(user, user.password).deliver_now

    assert_emails 0
  end

  def test_should_sent_redmine_info_for_user_with_company_email
    user = @user
    user.mail = "newone@efigence.com"
    user.save

    Mailer.account_activated(user).deliver_now

    assert_emails 1
    assert_mail_body_match "This is additional text for testing", ActionMailer::Base.deliveries.last
  end

  def test_should_not_sent_redmine_info_for_other_users
    user = @user
    user.save

    Mailer.account_activated(user).deliver_now

    assert_emails 1
    assert_mail_body_no_match "This is additional text for testing", ActionMailer::Base.deliveries.last
  end

end
