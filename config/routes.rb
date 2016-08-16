Rails.application.routes.draw do
  resources :answers
  resources :questions
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "registrations#new"

  namespace :account do
    resources :users do
      member do
        get :new_profile
        get :edit_profile
        put :update_profile
        get :show_profile
      end
    end
  end

end
