FactoryBot.define do
  factory :attachment do
    attachmentable nil
    file { Rack::Test::UploadedFile.new("#{Rails.root}/README.md") }
  end
end
