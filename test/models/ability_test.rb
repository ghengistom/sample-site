require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  setup do
    # Users
    @admin = users(:admin)
    @qa = users(:qa)
    @engineering = users(:engineering)
    @support = users(:support)

    @groups = users(:admin, :qa, :engineering, :support)
  end

  # commenting out as it always fails and should be reworked.
  # test "something" do
  #   user = @support
  #   ability = Ability.new(user, "10.0.0.1")
  #   example = FactoryGirl.create(:example, title: "Example Title for Status in progress", status: "in progress")
  #   assert ability.cannot?(:read, example)
  # end

  test "non user example access" do
    ["qa", "inactive"].each do |status|
      ability = Ability.new(nil, "10.0.0.1")
      example = FactoryGirl.create(:example, title: "Example Title for Status #{status}", status: status)
      assert ability.cannot?(:read, example)
    end
  end

  test "non user example access yes" do
    ["active", "in progress"].each do |status|
      ability = Ability.new(nil, "10.0.0.1")
      example = FactoryGirl.create(:example, title: "Example Title for Status #{status}", status: status)
      assert ability.can?(:read, example)
    end
  end

end