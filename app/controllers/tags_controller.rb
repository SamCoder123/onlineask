class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @questions = Question.tagged_with(@tag.name)
    @questions = @questions.paginate(:page => params[:page], :per_page => 6)
  end
end
