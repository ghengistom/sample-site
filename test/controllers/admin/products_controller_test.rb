require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    # Categories
    @product = FactoryGirl.create(:product, name: "Examples")

    # Abilities
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @ability.can :manage, Product

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
    
    get :edit, id: @product.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can ACCESS edit" do
    @controller.stubs(:current_ability).returns(@ability)
    
    get :edit, id: @product.id

    assert_response :success
    assert :alert != nil
  end

  test "USER cannot CREATE" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :create, product: {name: "Tester"}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can CREATE" do
    @controller.stubs(:current_ability).returns(@ability)

    put :create, product: {name: "Tester"}

    assert_redirected_to admin_products_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:create_success))
  end

  test "USER cannot EDIT" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :update, id: @product.id, product: {name: "Exampler"}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can EDIT" do
    @controller.stubs(:current_ability).returns(@ability)

    put :update, id: @product.id, product: {name: "Exampler"}

    assert_redirected_to admin_products_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:update_success))
  end

  test "USER cannot DESTROY" do
    product = FactoryGirl.create(:product, name: "Deleter")

    @controller.stubs(:current_ability).returns(@ability_none)

    put :destroy, id: product.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can DESTROY" do
    product = FactoryGirl.create(:product, name: "Deleter")

    @controller.stubs(:current_ability).returns(@ability)

    put :destroy, id: product.id

    assert_redirected_to admin_products_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:delete_success))
  end

end
