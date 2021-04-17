class EventCommentsController < ApplicationController
before_action :event_comment_params
  def create
    @comment = EventComment.new(event_comment_params)
    @comment.event_id = params[:format].to_i
    @comment.user_id = current_user.id
      if @comment.save
        # binding.pry
        @comments = EventComment.where(event_id:@comment[:event_id])
      else
        # render :new
        redirect_to event_path,notice: "コメントできませんでした。！"
      end
  end

  private
    def event_comment_params
      params.require(:event_comment).permit( :comment, :event_id)
    end

end
