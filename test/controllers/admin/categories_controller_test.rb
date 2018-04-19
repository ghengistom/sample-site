require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    # Categories
    @category = FactoryGirl.create(:category, name: "Testing")

    # Abilities
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @ability.can :manage, Category

    @ability_none = Object.new
    @ability_none.extend(CanCan::Ability)
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
    
    get :edit, id: @category.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can ACCESS edit" do
    @controller.stubs(:current_ability).returns(@ability)
    
    get :edit, id: @category.id

    assert_response :success
    assert :alert != nil
  end

  test "USER cannot CREATE" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :create, category: {name: "Other Testing"}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can CREATE" do
    @controller.stubs(:current_ability).returns(@ability)

    put :create, category: {name: "Other Testing"}

    assert_redirected_to admin_categories_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:create_success))
  end

  test "USER cannot EDIT" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :update, id: @category.id, category: {name: "New testing"}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can EDIT" do
    @controller.stubs(:current_ability).returns(@ability)

    put :update, id: @category.id, category: {name: "New testing"}

    assert_redirected_to admin_categories_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:update_success))
  end

  test "USER cannot DESTROY" do
    category = FactoryGirl.create(:category, name: "Testing delete")

    @controller.stubs(:current_ability).returns(@ability_none)

    put :destroy, id: category.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can DESTROY" do
    category = FactoryGirl.create(:category, name: "Testing delete")

    @controller.stubs(:current_ability).returns(@ability)

    put :destroy, id: category.id

    assert_redirected_to admin_categories_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:delete_success))
  end

end
