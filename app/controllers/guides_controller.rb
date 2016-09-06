class GuidesController < ApplicationController
  layout "guide"

  def tags_guide
    @tags = Tag.all
  end

  def replyers_guide
    @replyers = User.where(role: "replyer").limit(12)
  end
end
