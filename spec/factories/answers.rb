FactoryGirl.define do
  factory :answer do
    title "MyAnswer"
    sequence(:body) { |n| "Answer #{n}" }
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    title nil
    body nil
    question
    user
  end
end
