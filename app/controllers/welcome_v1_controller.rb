class WelcomeV1Controller < ApplicationController
  layout "welcome_v1"

  layout:false,only: [:register_guide]

  def index
    # @questions = Question.all

    @questions = Question.published.where(status:"closed").order("watches DESC").limit(4)

    if current_user
      if current_user.admin?
        redirect_to admin_admins_path
      end
    end
  end
end
