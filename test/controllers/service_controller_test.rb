require 'test_helper'

class ServiceControllerTest < ActionController::TestCase
  test "should get verify_user" do
    get :verify_user
    assert_response :success
  end

end
