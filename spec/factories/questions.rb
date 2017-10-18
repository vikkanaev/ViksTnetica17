FactoryGirl.define do
  sequence :title do |n|
    "Title #{n}"
  end
  sequence :body do |n|
    "Message #{n}"
  end

  factory :question do
    title
    body
    user
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    user
  end
end
