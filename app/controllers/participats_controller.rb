# class ParticipatsController < ApplicationController
# before_action :set_event, only: [:update]
#
#  def update
#     if params[:commit] == "申し込み"
#      @event.participat_id = current_user.id
#     elsif params[:participat_status] == "cancel"
#      @event.participat_id = nil
#     end
#     if @event.update(event_params)
#       redirect_to users_path, notice: "参加状況を編集しました！"
#     else
#       render :edit
#     end
#  end
#
#    private
#
#    def set_event
#      @event = Event.find(params[:id])
#    end
#
# end
