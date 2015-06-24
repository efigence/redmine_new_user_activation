require File.expand_path('../../test_helper', __FILE__)

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(:firstname => "new", :lastname => "user", :mail => "newuser@somenet.foo")
    @user.login = "new_user"
  end

  def test_should_create_user_with_future_activation_date
    assert_difference 'User.count', +1 do
      @user.activation_date = Time.now+1.year
      @user.save
    end
  end

  def test_should_create_user_without_activation_date
    assert_difference 'User.count', +1 do
      @user.save
    end
  end

  def test_should_not_create_user_with_past_activation_date
    assert_no_difference 'User.count' do
      @user.activation_date = "2006-07-19 22:57:52 +02:00"
      @user.save
    end
  end

  def test_should_set_status_to_pending_with_given_activation_date
    @user.activation_date = Time.now+1.month
    @user.save

    assert_equal User::STATUS_PENDING, @user.status
  end

  def test_should_set_status_to_active_without_given_activation_date
    @user.save

    assert_equal User::STATUS_ACTIVE, @user.status
  end

  def test_should_modify_activation_date_for_user_with_pending_status
    @user.save
    @user.set_pending
    @user.activation_date = Date.today+1.week

    assert_equal Date.today+1.week, @user.activation_date
  end

  def test_should_not_modify_activation_date_for_user_with_not_pending_status
    @user.save
    @user.activation_date = Time.now
    @user.save

    assert_equal nil, @user.activation_date
  end

end
