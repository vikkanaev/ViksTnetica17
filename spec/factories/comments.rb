FactoryBot.define do
  factory :comment do
    sequence(:message) { |n| "MyComment #{n}" }
    question
    user
  end

  factory :invalid_comment, class: 'Comment' do
    message nil
    question
    user
  end
end
