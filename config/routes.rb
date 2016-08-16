Rails.application.routes.draw do
  resources :answers

  resources :questions do
    resources :answers
  end

  devise_for :users

  namespace :account do
    resources :answers
    resources :questions
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
