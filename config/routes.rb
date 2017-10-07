Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions  do
    resources :answers, except: [:update, :destroy]
  end
  resources :answers, only: [:update, :destroy]
end
