Rails.application.routes.draw do

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

  # root "registrations#new"

  namespace :account do

    resources :answers do
      member do
        post :publish_hidden
      end
    end

    resources :questions do
      member do
        post :to_downpayment
        post :publish_hidden
      end
    end

    resources :users do
      member do
        get :new_image
        get :create_image
        get :new_profile
        get :edit_profile
        put :update_profile
        get :show_profile
      end
      # add withdraw actions
      member do
        get :withdraw_edit
        post :withdraw_change
      end
    end
  end

  namespace :admin do
    resources :users do
      member do
        post :change_to_admin
        post :change_to_user
      end
    end

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

    resources :admins do
      collection do
        get :questions_bill
      end
    end
  end
end
