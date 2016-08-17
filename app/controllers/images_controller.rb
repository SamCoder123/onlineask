class ImagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(params[:user_id])
    @image = Image.new
  end

  def create
    @user = User.find(params[:user_id])
    @image = Image.new(image_params)
    @image.user = current_user

    if @image.save
      flash[:notice] = "Successfully created..."
      redirect_to user_path(@user)
    else
      render :new
    end
    end

    def image_params
      params.require(:image).permit(:image, :content)
    end

  end
end
