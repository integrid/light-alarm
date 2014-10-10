require 'test_helper'

class UtilsControllerTest < ActionController::TestCase
  test "should get set" do
    get :set
    assert_response :success
  end

end
