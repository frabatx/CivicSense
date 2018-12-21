require 'test_helper'

class ScreamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scream = screams(:one)
  end

  test "should get index" do
    get screams_url
    assert_response :success
  end

  test "should get new" do
    get new_scream_url
    assert_response :success
  end

  test "should create scream" do
    assert_difference('Scream.count') do
      post screams_url, params: { scream: { category_id: @scream.category_id, description: @scream.description, latitude: @scream.latitude, longitude: @scream.longitude, priority: @scream.priority, screamer_email: @scream.screamer_email, status: @scream.status } }
    end

    assert_redirected_to scream_url(Scream.last)
  end

  test "should show scream" do
    get scream_url(@scream)
    assert_response :success
  end

  test "should get edit" do
    get edit_scream_url(@scream)
    assert_response :success
  end

  test "should update scream" do
    patch scream_url(@scream), params: { scream: { category_id: @scream.category_id, description: @scream.description, latitude: @scream.latitude, longitude: @scream.longitude, priority: @scream.priority, screamer_email: @scream.screamer_email, status: @scream.status } }
    assert_redirected_to scream_url(@scream)
  end

  test "should destroy scream" do
    assert_difference('Scream.count', -1) do
      delete scream_url(@scream)
    end

    assert_redirected_to screams_url
  end
end
