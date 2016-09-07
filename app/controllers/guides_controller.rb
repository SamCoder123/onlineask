class GuidesController < ApplicationController
  layout "guide", except: [:faq, :about, :contact]

  def tags_guide
    @tags = Tag.all
  end

  def replyers_guide
    @replyers = User.where(role: "replyer").limit(12)
  end

  def faq

  end

  def contact

  end

  def about

  end

end
