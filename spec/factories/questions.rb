FactoryGirl.define do
  factory :question do
    title 'MyQuestionTitle'
    body 'WAT?!'
  end

  factory :question2 do
    title 'MyQuestionTitle'
    body 'WAT?!'
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
