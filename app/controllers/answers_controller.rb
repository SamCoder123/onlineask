class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,only:[:create,:new,:edit,:update,:destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
  end

  # GET /answers/1/edit
  def edit
    @question = Question.find(params[:question_id])
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    @answer.user = current_user
    @answer.question = @question

    if @answer.save
      redirect_to questions_path, notice: '回答已发送！'
    else
      render :new
    end

    # respond_to do |format|
    #   if @answer.save
    #     format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
    #     format.json { render :show, status: :created, location: @answer }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @answer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if @answer.update(answer_params)
      redirect_to account_answers_path, notice: '回答已更新！'
    else
      render :edit
    end

    # respond_to do |format|
    #   if @answer.update(answer_params)
    #     format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @answer }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @answer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    redirect_to account_answers_path, notice: '回答已删除！'
    # respond_to do |format|
    #   format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:content)
    end
end
