class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # ログインしているかどうかを判定
  before_action :user_signed_in?
  before_action :authenticate_user!

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true)
  end

  def new
    @event = Event.new
  end

  def show
  end

  def edit
  end

  def update
    if params[:participat_status] == "申し込み"
      @event.update(participat_id: current_user.id)
      redirect_to events_path, notice: "参加を申し込みました！"
    elsif params[:participat_status] == "cancel"
      @event.update(participat_id: nil)
      redirect_to users_path, notice: "参加をキャンセルしました！"
    else
      @event.update(event_params)
      render :index
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
    # binding.pry
    params.require(:event).permit( :date, :title, :content, :start_point, :goal_point, :carry_price, :status, :participation, :participat_id)
  end
    private

    def set_event
      @event = Event.find(params[:id])
    end

end
