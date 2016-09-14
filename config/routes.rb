Rails.application.routes.draw do
  root "welcome_v1#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tags, only: %i(index show)

  resources :questions do
    member do
      post :question_like_up
      post :question_like_down
    end
    collection do
      get :search
      get :public_replyers
      get :show_replyer
    end

    resources :answers
  end

  resources :welcome_test, only: %i(index)

  resources :welcome_v1, only: %i(index)

  resources :guides do
    collection do
      get :tags_guide
      get :replyers_guide
      get :faq
      get :about
      get :contact
    end
  end

  # devise_for :users
  devise_for :users, controllers: { registrations: "registrations" }

  # namespace for account
  namespace :account do
    resources :blogs do
      member do
        get :ta_blogs
      end
    end

    resources :tags do
      member do
        post :cancel
        post :add_tag
      end
    end

    resources :answers do
      member do
        post :publish_hidden
        post :subscribe_answers
      end
    end

    resources :questions do
      member do
        post :to_downpayment
        post :publish_hidden
        post :cancel
        post :reopen
        patch :refine_reward
        get :my_favorite_questions
      end
      collection do
        get :invitated_questions
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
        get :index_profile
        get :my_questions_answers
        get :wallet
        # add withdraw actions
        get :withdraw_edit
        post :withdraw_change
        get :deposit_edit
        post :deposit_change
        get :exhibition_profile
        get :my_subscriptions
        # 显示我的关注
        get :follow_show
        post :submit_application
        post :add_tags
        get :reply
      end

      collection do
        get :replyers
        get :show_profile
      end
    end

    resources :follows, only: %i(like unlike) do
      member do
        post :like
        post :unlike
      end
    end
  end

  # namespace for admin
  namespace :admin do
    resources :users do
      member do
        post :change_to_admin
        post :change_to_user
        post :approved
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
        get :bill
      end
    end

    resources :tags
  end

  # 站内信
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  # vote功能
  namespace :vote do
    # 对answer的vote
    resources :vote_answers, only: %i(like,like_cancel,unlike,unlike_cancel) do
      member do
        post :like
        post :unlike
      end
    end
  end
end
