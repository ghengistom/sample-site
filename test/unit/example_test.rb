require 'test_helper'

class ExampleTest < ActiveSupport::TestCase
  # test "saving resets cache" do
  #   @example = FactoryGirl.build(:example)
  #   Rails.cache.expects(:delete_matched)
  #   assert @example.save
  # end
  
  test "clones should update status" do
    primary = FactoryGirl.create(:example, status: "in progress")
    1.upto(4) do
      FactoryGirl.create(:example, clone_id: primary.id, status: "in progress", code: nil)
    end

    assert_equal 5, Example.where(status: "in progress").count

    primary.status = "active"
    primary.save

    assert_equal 0, Example.where(status: "in progress").count    
    assert_equal 5, Example.where(status: "active").count
  end

  test "example titles shouldn't conflict" do
    # This test fails because it's not complete. TODO: This should be fixed.
    # primary = FactoryGirl.create(:example, title: "Asdf")
    # secondary = FactoryGirl.build(:example, title: "Asdf")
    # secondary.example_versions << ExampleVersion.new(product: primary.example_versions.first.product, version_id_start: primary.example_versions.first.version_id_start, version_id_end: primary.example_versions.first.version_id_start)
    # assert !secondary.save
    # assert_equal({:title => "asdf"}, secondary.errors.messages)
  end
end
