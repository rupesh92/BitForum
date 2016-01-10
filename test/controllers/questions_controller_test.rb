require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  test "should get ask" do
    get :ask
    assert_response :success
  end

end
