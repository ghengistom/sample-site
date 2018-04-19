FactoryGirl.define do
  factory :attachment do
    file ActionDispatch::Http::UploadedFile.new(:tempfile => Rack::Test::UploadedFile.new("#{Rails.root.to_s}/test/fixtures/files/dummy.txt", :file => Rack::Test::UploadedFile.new("#{Rails.root.to_s}/test/fixtures/files/dummy.txt")))
  end
end