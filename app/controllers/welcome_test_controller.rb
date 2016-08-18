class WelcomeTestController < ApplicationController

  layout "welcome_test"

  def index
      @questions = Question.all
  end
end
