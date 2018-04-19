require 'test_helper'

class Admin::VersionsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    # Categories
    @product = FactoryGirl.create(:product, name: "Tester")
    @version = FactoryGirl.create(:version, product: @product, name: "2015", sort_order: 2015)

    # Abilities
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @ability.can :manage, Version

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
    
    get :edit, id: @version.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can ACCESS edit" do
    @controller.stubs(:current_ability).returns(@ability)
    
    get :edit, id: @version.id

    assert_response :success
    assert :alert != nil
  end

  test "USER cannot CREATE" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :create, version: {product: @product, name: "2014", sort_order: 2014}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can CREATE" do
    @controller.stubs(:current_ability).returns(@ability)

    put :create, version: {product_id: 1, name: "2014", sort_order: 2014, status: "active"}

    assert_redirected_to admin_versions_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:create_success))
  end

  test "USER cannot EDIT" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :update, id: @version.id, version: {name: "2016"}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can EDIT" do
    @controller.stubs(:current_ability).returns(@ability)

    put :update, id: @version.id, version: {name: "2016"}

    assert_redirected_to admin_versions_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:update_success))
  end

  test "USER cannot DESTROY" do
    version = FactoryGirl.create(:version, product: @product, name: "2017")

    @controller.stubs(:current_ability).returns(@ability_none)

    put :destroy, id: version.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can DESTROY" do
    version = FactoryGirl.create(:version, product: @product, name: "2017")

    @controller.stubs(:current_ability).returns(@ability)

    put :destroy, id: version.id

    assert_redirected_to admin_versions_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:delete_success))
  end

end
