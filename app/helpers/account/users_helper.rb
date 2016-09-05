module Account::UsersHelper
  def avatar_url
    "https://en.gravatar.com/userimage/108935282/73e80187e488d35c459472b0fbd720f4.png"
    # "/public/headshot.png"
  end

  def controller?(controller)
    controller.include?(params[:controller])
  end

  def action?(action)
    action.include?(params[:action])
  end

  def render_check_nil_or_display(user_attribute, alternative)
    if user_attribute.nil?
      alternative
    else
      user_attribute
    end
  end

  def display_user_status(user)
    case user.aasm_state
    when "unapplied"
      content_tag(:span, "申请成为学霸", class: "fa fa-user")
    when "application_applied"
      content_tag(:span, "学霸申请中", class: "fa fa-star-o")
    when "application_approved"
      content_tag(:span, "已认证为学霸", class:"fa fa-star")
    end
  end

  def render_count_user_fans(user)
    user.follow_relationships.where(follower_id: current_user).size
  end


end
