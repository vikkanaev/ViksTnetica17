FactoryGirl.define do
  factory :answer do
    title "MyAnswer"
    body "MyTextT"
  end

  factory :invalid_answer, class: 'Answer' do
    title nil
    body nil
  end
end
