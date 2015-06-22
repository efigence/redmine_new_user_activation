require File.expand_path('../../test_helper', __FILE__)

class AccountTest < Redmine::IntegrationTest
  fixtures :users

  def setup
    log_user("admin", "admin")
  end

  def test_hook_should_fetch_activation_date
    get '/users/1/edit'
    assert_response :success
    assert_select '#user_activation_date'
  end

end
