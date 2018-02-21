require 'test_helper'

class ChartsControllerTest < ActionDispatch::IntegrationTest
  test "should get messages_per_hour" do
    get charts_messages_per_hour_url
    assert_response :success
  end

end
