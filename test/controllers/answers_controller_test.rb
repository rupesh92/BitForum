require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

end
