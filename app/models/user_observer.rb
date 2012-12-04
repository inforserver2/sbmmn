class UserObserver < ActiveRecord::Observer
  observe :user
  def before_create user
    user.generate_token(:auth_token)
    user.build_visit_counter
    user.build_profile redir_from: user.profile_redir_from
  end
end
