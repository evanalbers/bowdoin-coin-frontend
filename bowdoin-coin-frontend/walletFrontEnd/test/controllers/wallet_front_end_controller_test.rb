require "test_helper"

class WalletFrontEndControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wallet_front_end_index_url
    assert_response :success
  end
end
