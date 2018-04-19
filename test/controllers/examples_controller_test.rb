require 'test_helper'

class ExamplesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    FactoryGirl.create(:example, title: "asdf bookmarks", status: "inactive")
    FactoryGirl.create(:example, title: "asdf bookmarks in progress", status: "in progress")
    FactoryGirl.create(:example, title: "Lots of bookmarks", status: "active")

    # Users
    @admin = users(:admin)
    @qa = users(:qa)
    @engineering = users(:engineering)
    @support = users(:support)
    @nobody = users(:nobody)

    @groups = users(:admin, :engineering, :support)
  end

  test "search will not find inactive examples" do
    get :search, q: "asdf", language: ""
    assert_response :success
    assert_not_nil assigns(:by_title)
    assert assigns(:by_title).empty?
  end

  test "search will find active examples" do
    get :search, q: "bookmarks", language: ""
    assert_response :success
    assert_not_nil assigns(:by_title)
    assert_equal 1, assigns(:by_title).length
    assert_equal "Lots of bookmarks", assigns(:by_title).first.title
  end

  test "search should redirect to example if exact match found" do
    get :search, q: "Lots of bookmarks", language: "", format: :js
    assert_response :success
    assert_operator -1, :<, @response.body =~ /window\.location/
  end

  test "search should not crash on SQL injection" do
    get :search, q: "Lot's of bookmarks", language: "", format: :js
    assert_response :success
    assert_equal [], assigns(:by_title)
  end

  test "get example by product and year" do
    product = FactoryGirl.create(:product, name: "Asdf")
    version1 = FactoryGirl.create(:version, product: product, name: "2011")
    version2 = FactoryGirl.create(:version, product: product, name: "2012")

    example1 = FactoryGirl.build(:example, status: "active", title: "Testing")
    example1.example_versions << ExampleVersion.new(product: product, version_id_start: version1.id, version_id_end: version1.id)
    example1.category = Category.first || FactoryGirl.create(:category)
    example1.save

    example2 = FactoryGirl.build(:example, status: "active", title: "Testing")
    example2.example_versions << ExampleVersion.new(product: product, version_id_start: version2.id)
    example2.category = Category.first
    example2.save

    get :show, product: "Asdf", version: "2011", title: "Testing"
    assert_response :success
    assert_equal Example.find(example1.id), assigns(:example)

    get :show, product: "Asdf", version: "2012", title: "Testing"
    assert_response :success
    assert_equal Example.find(example2.id), assigns(:example)
  end

  test "get example list by product" do
    product = FactoryGirl.create(:product, name: "Asdf")
    version1 = FactoryGirl.create(:version, product: product, name: "2011")
    version2 = FactoryGirl.create(:version, product: product, name: "2012")

    example1 = FactoryGirl.build(:example, status: "active", title: "Testing")
    example1.example_versions << ExampleVersion.new(product: product, version_id_start: version1.id, version_id_end: version1.id)
    example1.category = Category.first || FactoryGirl.create(:category)
    example1.save

    example2 = FactoryGirl.build(:example, status: "active", title: "Testing")
    example2.example_versions << ExampleVersion.new(product: product, version_id_start: version2.id)
    example2.category = Category.first || FactoryGirl.create(:category)
    example2.save

    get :show, product: "Asdf"
    assert_response :success
    assert_equal version2, assigns(:version)
    assert_equal example2, assigns(:examples_functions).first
    assert_equal 1, assigns(:examples_functions).length

    # try it again, but this time, it should find the other version, since the latest is actually future
    version2.update_attribute :status, "future"

    get :show, product: "Asdf"
    assert_response :success
    assert_equal version1, assigns(:version)
    assert_equal example1, assigns(:examples_functions).first
    assert_equal 1, assigns(:examples_functions).length
  end

  test "users that should access all example statuses" do
    example = FactoryGirl.create(:example, title: "Example Title for Status??????")
    
    ability = Object.new
    ability.extend(CanCan::Ability)
    ability.can :read, example
    @controller.stubs(:current_ability).returns(ability)

    get :show, product: example.products[0].name, version: example.example_versions[0].version_start.name, title: example.title

    assert_response :success
    assert_not_nil assigns(:example)
  end

  test "user cannot access example should be redirected" do
    example = FactoryGirl.create(:example, title: "Example Title for Status")
      
    ability = Object.new
    ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(ability)

    get :show, product: example.products[0].name, version: example.example_versions[0].version_start.name, title: example.title

    assert_response :redirect
    assert_redirected_to root_path
  end

end
