class ReviewsController < ApplicationController

  before_action :review_creator?, :only => [:edit, :update, :destroy]

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def create
    if  current_user != nil
  		@restaurant = Restaurant.find(params[:restaurant_id])
  		@review = @restaurant.reviews.create(review_params)
      @review.user_id = current_user.id 
  		if @review.save
  			redirect_to restaurants_path
  		else
  			render 'new'
  		end
    else
      flash[:notice] = "You aren't logged in"
      redirect_to new_user_session_path
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
    if  current_user != nil
      unless @review.user_id == current_user.id 
        flash[:notice] = "You aren't the restaurant creator"
        redirect_to restaurants_path
      end
    else
      flash[:notice] = "You aren't the logged in"
      redirect_to new_user_session_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  	flash[:notice] = 'Review deleted successfully'
  	redirect_to '/restaurants'
  end
end

