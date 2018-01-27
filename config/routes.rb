Rails.application.routes.draw do
  use_doorkeeper
  get 'authorizations/new'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root to: "questions#index"

  concern :votable do
      patch 'vote_up', to: 'votes#vote_up'
      patch 'vote_down', to: 'votes#vote_down'
      patch 'vote_cancel', to: 'votes#vote_cancel'
  end

  concern :commetable do
    resources :comments, shallow: true
  end

  resources :questions, concerns: [:votable, :commetable]  do
    resources :answers, concerns: [:votable, :commetable], shallow: true do
      patch 'set_best_answer_ever', on: :member, as: :set_best
    end
  end

  resources :attachments, only: :destroy
  mount ActionCable.server => "/cable"

  resources :authorizations, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end
    end
  end
end
