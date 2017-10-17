FactoryGirl.define do
  factory :question do
    title 'MyQuestionTitle'
    body 'WAT?!'
    user
  end

  factory :question2 do
    title 'MyQuestionTitle'
    body 'WAT?!'
    user
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    user
  end
end
