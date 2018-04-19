require 'test_helper'

class Admin::AttachmentsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    # Attachments
    @file = "#{Rails.root.to_s}/test/fixtures/files/dummy.txt"
    @file2 = "#{Rails.root.to_s}/test/fixtures/files/dummy2.txt"
    @attachment = FactoryGirl.create(:attachment, :file => Rack::Test::UploadedFile.new(@file))

    # Abilities
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @ability.can :manage, Attachment

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
    
    get :edit, id: @attachment.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can ACCESS edit" do
    @controller.stubs(:current_ability).returns(@ability)
    
    get :edit, id: @attachment.id

    assert_response :success
    assert :alert != nil
  end

  test "USER cannot CREATE" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :create, attachment: {:file => Rack::Test::UploadedFile.new(@file)}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can CREATE" do
    @controller.stubs(:current_ability).returns(@ability)

    put :create, attachment: {:file => Rack::Test::UploadedFile.new(@file)}

    assert_response :success
    # assert :notice != nil
    # assert_equal I18n.t(:create_success), flash[:notice]
  end

  test "USER cannot EDIT" do
    @controller.stubs(:current_ability).returns(@ability_none)

    put :update, id: @attachment.id, attachment: {file: Rack::Test::UploadedFile.new(@file2)}

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can EDIT" do
    @controller.stubs(:current_ability).returns(@ability)

    put :update, id: @attachment.id, attachment: {file: Rack::Test::UploadedFile.new(@file2)}

    assert_redirected_to admin_attachments_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:update_success))
  end

  test "USER cannot DESTROY" do
    attachment = FactoryGirl.create(:attachment, :file => Rack::Test::UploadedFile.new(@file2))

    @controller.stubs(:current_ability).returns(@ability_none)

    put :destroy, id: attachment.id

    assert_response :redirect
    assert :alert != nil
    assert_equal I18n.t(:access_denied), flash[:alert]
  end

  test "USER can DESTROY" do
    attachment = FactoryGirl.create(:attachment, :file => Rack::Test::UploadedFile.new(@file2))

    @controller.stubs(:current_ability).returns(@ability)

    put :destroy, id: attachment.id

    assert_redirected_to admin_attachments_path
    assert :notice != nil
    assert flash[:notice].include?(I18n.t(:delete_success))
  end

end
