module Account::UsersHelper
  def avatar_url
    "https://en.gravatar.com/userimage/108935282/73e80187e488d35c459472b0fbd720f4.png"
  end

  def controller?(controller)
    controller.include?(params[:controller])
  end

  def action?(action)
    action.include?(params[:action])
  end


end
