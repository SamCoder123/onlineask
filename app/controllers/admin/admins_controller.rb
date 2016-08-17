class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!

  def questions_bill
    @questions = Question.all
  end
end
