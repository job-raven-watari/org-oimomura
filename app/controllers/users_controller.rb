class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :likes]
  def index
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order("created_at DESC").page(params[:page]).per(5)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "会員登録が完了しました！"
      redirect_to @user
    else
      flash.now[:danger] = "会員登録に失敗しました"
      render :new
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @reviews = @user.likes_reviews.page(params[:page]).per(5)
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end
end
