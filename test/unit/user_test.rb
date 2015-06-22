require File.expand_path('../../test_helper', __FILE__)

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user = User.new(:firstname => "new", :lastname => "user", :mail => "newuser@somenet.foo")
  end

  def test_should_create_user_with_future_activation_date
    assert_difference 'User.count', +1 do
      user = @user
      user.login = "new_user"
      user.activation_date = "<%= Time.now+1.month %>"
      user.save
    end
  end

  def test_should_create_user_without_activation_date
    assert_difference 'User.count', +1 do
      user = @user
      user.login = "new_user"
      @user.save
    end
  end

  def test_should_not_create_user_with_past_activation_date
    assert_no_difference 'User.count' do
      user = @user
      user.login = "new_user"
      @user.activation_date = "2006-07-19 22:57:52 +02:00"
      @user.save
    end
  end

end
