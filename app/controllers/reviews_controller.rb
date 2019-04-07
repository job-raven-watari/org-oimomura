class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @review = Review.find(params[:id])
  end
  
  def create
    @review =current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "クチコミを投稿しました"
      redirect_to root_url
    else
      @reviews = Review.order("created_at DESC").page(params[:page])
      flash.now[:danger] = "クチコミの投稿ができませんでした"
      render "toppages/index"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:success] = "クチコミを削除しました"
    redirect_to root_url
  end
  
  private
  
  def review_params
    params.require(:review).permit(:kind, :point, :product_name, :producing_area, :comment)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
end
