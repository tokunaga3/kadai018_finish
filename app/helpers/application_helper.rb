module ApplicationHelper
  def users_comments_classchage(comment_user)
    if current_user.id == comment_user.id
      "current_user_class offset-6 col-6"
    else
      "other_user_class col-6 ofset-6"
    end
  end

end
