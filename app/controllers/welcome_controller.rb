class WelcomeController < ApplicationController
  def index
    # @questions = Question.all
    @questions = Question.limit(6).order('id desc')
  end
end
