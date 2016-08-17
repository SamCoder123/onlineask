class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  def questions_bill
    @questions = Question.all
  end
end
