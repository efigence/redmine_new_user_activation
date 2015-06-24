require File.expand_path('../../test_helper', __FILE__)

class AccountControllerTest < ActionController::TestCase
  fixtures :users

  def setup
    User.current = nil
  end

  def test_login_should_not_allow_login_with_pending_status
    post :login, :username => 'admin', :password => 'admin'
    assert_redirected_to '/login'
    assert_include 'locked', flash[:error]
    assert_nil @request.session[:user_id]
  end

end
