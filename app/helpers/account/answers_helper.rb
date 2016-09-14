module Account::AnswersHelper
  def render_user_auth?(user)
    current_user && current_user == user
  end

end
