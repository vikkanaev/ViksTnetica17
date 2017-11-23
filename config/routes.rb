Rails.application.routes.draw do
  get 'votes/update'

  devise_for :users
  root to: "questions#index"

  resources :questions  do
    patch 'vote_up', to: 'votes#vote_up'
    patch 'vote_down', to: 'votes#vote_down'
    patch 'vote_cancel', to: 'votes#vote_cancel'
    resources :answers, shallow: true do
      patch 'set_best_answer_ever', on: :member, as: :set_best
      patch 'vote_up', to: 'votes#vote_up'
      patch 'vote_down', to: 'votes#vote_down'
      patch 'vote_cancel', to: 'votes#vote_cancel'
    end
  end

  resources :attachments, only: :destroy
end
