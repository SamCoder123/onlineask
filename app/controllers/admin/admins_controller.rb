class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  def questions_bill
    @open_questions = Question.where(status: 'open')
    @closed_questions = Question.where(status: 'closed')
  end
end
