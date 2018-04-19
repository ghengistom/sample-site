require 'test_helper'

class SnippetsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  test "should get show" do
    assert_raises(RuntimeError) { get :show }
  end

end
