FactoryGirl.define do
  factory :answer do
    title "MyAnswer"
    body "MyText to answers of..."
  end

  factory :invalid_answer, class: 'Answer' do
    title nil
    body nil
  end
end
