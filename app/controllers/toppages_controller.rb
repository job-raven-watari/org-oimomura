class ToppagesController < ApplicationController

  def index
    @reviews_1 = Review.limit(3).order("created_at DESC")

    if logged_in?
      @review = current_user.reviews.build
      @reviews = Review.order("created_at DESC").page(params[:page]).per(5)
      counts(current_user)
    end
  end
end
