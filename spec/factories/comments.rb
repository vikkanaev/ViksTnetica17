FactoryBot.define do
  factory :comment, class: 'Comment' do |comment|
    comment.commentable { |c| c.association(:question) }
    sequence(:message) { |n| "MyComment #{n}" }
    user
  end

  factory :invalid_comment, class: 'Comment' do
    message nil
    question
    user
  end
end
