Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  concern :votable do
      patch 'vote_up', to: 'votes#vote_up'
      patch 'vote_down', to: 'votes#vote_down'
      patch 'vote_cancel', to: 'votes#vote_cancel'
  end

  resources :questions, concerns: :votable  do
    resources :comments, shallow: true
    resources :answers, concerns: :votable, shallow: true do
      patch 'set_best_answer_ever', on: :member, as: :set_best
    end
  end

  resources :attachments, only: :destroy
  mount ActionCable.server => "/cable"
end
