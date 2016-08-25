class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"

  def index
    @questions = Question.all
    @answers = Answer.all
    @users = User.all
    drop_breadcrumb("后台首页")
  end

  def questions_bill
    @open_questions = Question.where(status: "open")
    @closed_questions = Question.where(status: "closed")
  end
end
