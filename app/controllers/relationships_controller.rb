class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js # 存在するアクションのrespondを全てjsで返す場合はこのような記述でも可能。
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # redirect_to user_path
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    # redirect_to user_path
  end
end
