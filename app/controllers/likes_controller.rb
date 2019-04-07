class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    review = Review.find(params[:review_id])
    current_user.like(review)
    flash[:success] = "イモ惚れボタンを押しました"
    redirect_to likes_user_path(current_user)
  end
  
  def destroy
    review = Review.find(params[:review_id])
    current_user.unlike(review)
    flash[:success] = "イモ惚れボタンを解除しました"
    redirect_to likes_user_path(current_user)
  end
end
