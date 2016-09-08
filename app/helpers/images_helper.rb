module ImagesHelper
  def render_head_image_30(user)
    if user.image.present?
      image_tag user.image, class:"img-circle profile_image_30"
    else
      image_tag("/default_image.png", class: "img-circle profile_image_30")
    end
  end

  def render_head_image_100(user)
    if user.image.present?
      image_tag user.image, class:"img-circle profile_image_100"
    else
      image_tag("/default_image.png", class: "img-circle profile_image_100")
    end
  end

    def render_head_image_130(user)
      if user.image.present?
        image_tag user.image, class:"img-circle profile_image_130"
      else
        image_tag("/default_image.png", class: "img-circle profile_image_130")
      end
    end

    def render_head_image_20(user)
      if user.image.present?
        image_tag(user.image, class:"img-circle profile_image_20",:style => "height:20px !important;")
      else
        image_tag("/default_image.png", class: "img-circle profile_image_20",:style => "height:20px !important;")
      end
    end
end
