require 'test_helper'

class InternetSlangWordsControllerTest < ActionController::TestCase
  setup do
    @internet_slang_word = internet_slang_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internet_slang_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internet_slang_word" do
    assert_difference('InternetSlangWord.count') do
      post :create, :internet_slang_word => @internet_slang_word.attributes
    end

    assert_redirected_to internet_slang_word_path(assigns(:internet_slang_word))
  end

  test "should show internet_slang_word" do
    get :show, :id => @internet_slang_word.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @internet_slang_word.to_param
    assert_response :success
  end

  test "should update internet_slang_word" do
    put :update, :id => @internet_slang_word.to_param, :internet_slang_word => @internet_slang_word.attributes
    assert_redirected_to internet_slang_word_path(assigns(:internet_slang_word))
  end

  test "should destroy internet_slang_word" do
    assert_difference('InternetSlangWord.count', -1) do
      delete :destroy, :id => @internet_slang_word.to_param
    end

    assert_redirected_to internet_slang_words_path
  end
end
