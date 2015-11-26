class ReviewsController < ApplicationController

  before_action :review_creator?, :only => [:edit, :update, :destroy]

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = @restaurant.reviews.create(review_params)
    @review.user_id = current_user.id
		if @review.save
			redirect_to restaurants_path
		else
			render 'new'
		end
	end

	def review_params
		params.require(:review).permit(:thoughts, :rating)
	end

	def edit
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.find(params[:id])
	end

	def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to '/restaurants'
    else
      render 'edit'
    end
  end

  def review_creator?
    @review = Review.find(params[:id])
    unless current_user.id == @review.user_id
      flash[:notice] = "You aren't the review creator"
      redirect_to restaurants_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  	flash[:notice] = 'Review deleted successfully'
  	redirect_to '/restaurants'
  end
end

