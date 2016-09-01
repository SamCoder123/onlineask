class GuidesController < ApplicationController
  def tags_guide
    @tags = Tag.all
  end
end
