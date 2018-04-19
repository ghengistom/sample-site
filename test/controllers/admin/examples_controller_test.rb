require 'test_helper'

class Admin::ExamplesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    # Example prep
    @product = FactoryGirl.create(:product, name: "Tester")
    @version = FactoryGirl.create(:version, product: @product, name: "2011")
    @example = FactoryGirl.build(:example, status: "active", title: "Testing examples controller")
    @example.example_versions << ExampleVersion.new(product: @product, version_id_start: @version.id)
    @example.category = Category.first || FactoryGirl.create(:category)
    @example.save

    @new_title = "New title"

    # Users
    @admin = users(:admin)
    @qa = users(:qa)
    @engineering = users(:engineering)
    @support = users(:support)
    @nobody = users(:nobody)

    @groups = users(:admin, :qa, :engineering, :support)
  end


  test "USER: cannot ACCESS: Edit Example" do
    ability = Object.new
    ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(ability)

    get :edit, id: @example.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER: can ACCESS: Edit Example" do
    ability = Object.new
    ability.extend(CanCan::Ability)
    ability.can :manage, @example
    @controller.stubs(:current_ability).returns(ability)
    @controller.stubs(:current_user).returns(@nobody)

    get :edit, id: @example.id

    assert_response :success
    assert :alert != nil
  end

  test "USER: cannot UPDATE: Example" do
    ability = Object.new
    ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(ability)

    put :update, id: @example.id, example: {title: @new_title}

    assert_response :redirect
    assert :alert != nil
    assert flash[:alert].include?(I18n.t(:access_denied))
  end

  test "USER: can UPDATE: Example" do
    ability = Object.new
    ability.extend(CanCan::Ability)
    ability.can :manage, @example
    @controller.stubs(:current_ability).returns(ability)

    put :update, id: @example.id, example: {title: @new_title}

    assert_redirected_to examples_path(product: @product.name, version: @version.name, title: @new_title)
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:update_success))
  end
end
