Rails.application.routes.draw do
  resources :answers
  resources :questions do
    resources :answers
  end
  devise_for :users

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :questions do
      member do
        post :hide
        post :publish
      end
    end
    resources :answers do
      member do
        post :hide
        post :publish
      end
    end
  end

  namespace :account do
    resources :answers
    resources :questions 
  end

end
