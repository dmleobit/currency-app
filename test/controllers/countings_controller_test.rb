require 'test_helper'

class CountingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @counting = countings(:one)
  end

  test "should get index" do
    get countings_url
    assert_response :success
  end

  test "should get new" do
    get new_counting_url
    assert_response :success
  end

  test "should create counting" do
    assert_difference('Counting.count') do
      post countings_url, params: { counting: {  } }
    end

    assert_redirected_to counting_url(Counting.last)
  end

  test "should show counting" do
    get counting_url(@counting)
    assert_response :success
  end

  test "should get edit" do
    get edit_counting_url(@counting)
    assert_response :success
  end

  test "should update counting" do
    patch counting_url(@counting), params: { counting: {  } }
    assert_redirected_to counting_url(@counting)
  end

  test "should destroy counting" do
    assert_difference('Counting.count', -1) do
      delete counting_url(@counting)
    end

    assert_redirected_to countings_url
  end
end
