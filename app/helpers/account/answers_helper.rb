module Account::AnswersHelper
  def render_user_auth?(current_user,user)
    current_user && current_user == user
  end

end
