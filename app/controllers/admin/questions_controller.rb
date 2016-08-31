class Admin::QuestionsController < AdminController
  def index
    @questions = Question.all
    drop_breadcrumb("后台首页", admin_user_path(current_user))
    drop_breadcrumb("问题管理")
  end

  def show
    @question = Question.find(params[:id])
    drop_breadcrumb("问题管理", admin_questions_path)
    drop_breadcrumb(@question.title)
  end

  def hide
    @question = Question.find(params[:id])
    @question.hide!
    flash[:alert] = "你隐藏了问题#{@question.title}"
    redirect_to :back
  end

  def publish
    @question = Question.find(params[:id])
    @question.publish!
    flash[:alert] = "你公开了问题#{@question.title}"
    redirect_to :back
  end
end
