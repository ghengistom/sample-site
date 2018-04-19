require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    # Categories
    @user = FactoryGirl.create(:user, email: "user@domain.com")

    # Abilities
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @ability.can :manage, User

    @ability_none = Object.new
    @ability_none.extend(CanCan::Ability)


    @user = users(:admin)
    
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf"}
    end

    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: {email: "testing@test.com"}
    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to admin_users_path
  end

  test "USER cannot ACCESS index" do
    @controller.stubs(:current_ability).returns(@ability_none)
    
    get :index

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can ACCESS index" do
    @controller.stubs(:current_ability).returns(@ability)
    
    get :index

    assert_response :success
    assert :alert != nil
  end

  test "USER cannot ACCESS new" do
    @controller.stubs(:current_ability).returns(@ability_none)
    
    get :new

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can ACCESS new" do
    @controller.stubs(:current_ability).returns(@ability)
    
    get :new

    assert_response :success
    assert :alert != nil
  end

  test "USER cannot ACCESS Edit" do
    @controller.stubs(:current_ability).returns(@ability_none)
    
    get :edit, id: @user.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can ACCESS edit" do
    @controller.stubs(:current_ability).returns(@ability)
    
    get :edit, id: @user.id

    assert_response :success
    assert :alert != nil
  end

  test "USER cannot CREATE" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :create, user: {email: "someone@domain.com"}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can CREATE" do
    @controller.stubs(:current_ability).returns(@ability)

    put :create, user: {email: "someone@domain.com", password: "asdfasdf", password_confirmation: "asdfasdf"}

    assert_redirected_to admin_user_path(assigns(:user))
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:create_success))
  end

  test "USER cannot EDIT" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :update, id: @user.id, user: {email: "noone@domain.com"}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can EDIT" do
    @controller.stubs(:current_ability).returns(@ability)

    put :update, id: @user.id, user: {email: "noone@domain.com"}

    assert_redirected_to admin_user_path(@user)
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:update_success))
  end

  test "USER cannot DESTROY" do
    user = FactoryGirl.create(:user, email: "no@domain.com")

    @controller.stubs(:current_ability).returns(@ability_none)

    put :destroy, id: user.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can DESTROY" do
    user = FactoryGirl.create(:user, email: "no@domain.com")

    @controller.stubs(:current_ability).returns(@ability)

    put :destroy, id: user.id

    assert_redirected_to admin_users_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:delete_success))
  end

end
