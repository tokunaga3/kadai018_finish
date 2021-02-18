class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user_signed_in?
  before_action :authenticate_user!

  def index
    @user = User.find(current_user[:id])
    @participat = Event.all.where(participat_id:current_user[:id])
    @users = User.all
  end

  def show
  end

  def edit
  end

  # def destroy
  #   @user.destroy
  #   redirect_to users_path, notice:"イベントを削除しました！"
  # end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "ユーザ情報を編集しました"
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :user_content, :address, :image)
  end

    private
    def set_user
      @user = User.find(params[:id])
    end
  end
