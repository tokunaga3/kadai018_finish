class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # ログインしているかどうかを判定
  # before_action :authenticate_user!
  # before_action :user_signed_in?

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: "イベントを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice:"イベントを削除しました！"
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to events_path,notice: "イベントを追加しました！"
    else
      render :new
    end
  end

  def event_params
    params.require(:event).permit(:date, :title, :content, :start_point, :goal_point, :carry_price, :status)
  end
    private

    def set_event
      @event = Event.find(params[:id])
    end
    
end
