class WelcomeTestController < ApplicationController
  layout "welcome_test"

  def index
    # @questions = Question.all
    @questions = Question.limit(6)
    if current_user
      redirect_to show_profile_account_user_path(current_user)
    end
  end
end
