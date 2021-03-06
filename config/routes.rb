require 'sidekiq/web'

Rails.application.routes.draw do
  use_doorkeeper

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

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
    member do
      resources :subscriptions, only: [:create, :destroy], shallow: true
    end
    resources :answers, concerns: [:votable, :commetable], shallow: true do
      patch 'set_best_answer_ever', on: :member, as: :set_best
    end
  end

  resources :attachments, only: :destroy
  mount ActionCable.server => "/cable"

  resources :authorizations, only: [:new, :create]
  post 'search', to: 'searches#show'

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
        get :other_users_list, on: :collection
      end
      resources :questions, shallow: true do
        resources :answers
      end
    end
  end
end
