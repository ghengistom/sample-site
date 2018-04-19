require 'test_helper'

class SamplesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  test "verify hash data exists" do
    get :show, page: "echo", asdf: "qwer"
    assert_response :success
    assert_not_nil assigns(:data)
    assert assigns(:data).present?
    assert_equal "qwer", assigns(:data)["get"][:asdf]
  end

end
