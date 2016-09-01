class GuidesController < ApplicationController
  layout "guide"

  def tags_guide
    @tags = Tag.all
  end

  def replyers_guide
    replyers = User.where(role: "replyer")

    @replyers = replyers.paginate(:page => params[:page], :per_page => 12)
  end
end
