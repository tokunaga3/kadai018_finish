module ApplicationHelper
  def users_comments_classchage(comment_user)
    if current_user.id == comment_user.id
      "current_user_class"
    else
      "other_user_class"
    end
  end

end
