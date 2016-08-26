class WelcomeTestController < ApplicationController
  layout "welcome_test"

  def index
    # @questions = Question.all
    @questions = Question.limit(6)

    if request.referrer.include?('/users/sign_in') || request.referrer.include?('/users/sign_up')
      if current_user.admin?
        redirect_to admin_admins_path
      else
        redirect_to show_profile_account_user_path(current_user)
      end
    end
  end
end
