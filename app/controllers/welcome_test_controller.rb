class WelcomeTestController < ApplicationController
  layout "welcome_test"

  def index
    if current_user && current_user.is_admin
      redirect_to admin_admins_path
      return
    end
    if current_user
      redirect_to show_profile_account_user_path(current_user)
      return
    end
    # @questions = Question.all
    @questions = Question.limit(6)
  end
end
