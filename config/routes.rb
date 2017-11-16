Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :questions  do
    resources :answers, shallow: true do
      patch 'set_best_answer_ever', on: :member, as: :set_best
    end
  end

  resources :attachments, only: :destroy
end
