class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"

  def index
    @questions = Question.all
    @answers = Answer.all
    @users = User.all
    @bills = Bill.all
    drop_breadcrumb("后台首页")
  end

  def bill
    @open_questions = Question.where(status: "open")
    @closed_questions = Question.where(status: "closed")
    @bills =
      case params[:order_method]
      when "flow_in"
        Bill.where(flow: "in") # 多个筛选条件怎么搞？
      when "flow_out"
        Bill.where(flow: "out")
      when "question_deposit"
        Bill.where(detail: "提问押金")
      else
        Bill.all
      end
  end
end
