require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relationships_index_url
    assert_response :success
  end

  test "should get create" do
    get relationships_create_url
    assert_response :success
  end

  test "should get update" do
    get relationships_update_url
    assert_response :success
  end
end
