class CommentsController < ApplicationController
  def create
    @comment = Comment.new(event_comment_params)
    binding.pry
    @event.user_id = current_user.id
    if @comment.save
      redirect_to events_path,notice: "イベントを追加しました！"
    else
      render :new
    end
  end

  private
    def event_comment_params
      params.require(:event_comment).permit( :comment)
    end

end
