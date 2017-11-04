Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :questions  do
    resources :answers, shallow: true
  end
  patch  '/questions/:id/set_best_answer_ever/:best_answer_id', to: 'questions#set_best_answer_ever'
end
