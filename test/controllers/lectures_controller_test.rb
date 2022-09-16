require "test_helper"

class LecturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lecture = lectures(:one)
  end

  test "should get index" do
    get lectures_url, as: :json
    assert_response :success
  end

  test "should create lecture" do
    assert_difference('Lecture.count') do
      post lectures_url, params: { lecture: { duration: @lecture.duration, name: @lecture.name, start_time: @lecture.start_time } }, as: :json
    end

    assert_response 201
  end

  test "should show lecture" do
    get lecture_url(@lecture), as: :json
    assert_response :success
  end

  test "should update lecture" do
    patch lecture_url(@lecture), params: { lecture: { duration: @lecture.duration, name: @lecture.name, start_time: @lecture.start_time } }, as: :json
    assert_response 200
  end

  test "should destroy lecture" do
    assert_difference('Lecture.count', -1) do
      delete lecture_url(@lecture), as: :json
    end

    assert_response 204
  end
end
