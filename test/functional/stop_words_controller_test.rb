require 'test_helper'

class StopWordsControllerTest < ActionController::TestCase
  setup do
    @stop_word = stop_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stop_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stop_word" do
    assert_difference('StopWord.count') do
      post :create, :stop_word => @stop_word.attributes
    end

    assert_redirected_to stop_word_path(assigns(:stop_word))
  end

  test "should show stop_word" do
    get :show, :id => @stop_word.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @stop_word.to_param
    assert_response :success
  end

  test "should update stop_word" do
    put :update, :id => @stop_word.to_param, :stop_word => @stop_word.attributes
    assert_redirected_to stop_word_path(assigns(:stop_word))
  end

  test "should destroy stop_word" do
    assert_difference('StopWord.count', -1) do
      delete :destroy, :id => @stop_word.to_param
    end

    assert_redirected_to stop_words_path
  end
end
