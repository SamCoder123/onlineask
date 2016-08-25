class WelcomeTestController < ApplicationController
  layout "welcome_test"

  def index
    # @questions = Question.all
    @questions = Question.limit(6)
  end
end
