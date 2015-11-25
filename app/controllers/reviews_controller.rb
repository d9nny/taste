class ReviewsController < ApplicationController



	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@restaurant.reviews.create(review_params)
		p @restaurant.reviews.all
		redirect_to restaurants_path
	end

	def review_params
		params.require(:review).permit(:thoughts, :rating)
	end

	def edit
		# @restaurant = Restaurant.find(params[:restaurant_id])
		# p @restaurant.reviews.all
		@review = Review.find(params[:id])
	end

	def update
    @review = Review.find(params[:id])

    @review.update(review_params)

    redirect_to '/restaurants'
  end

  # def destroy
  # 	@restaurant = Restaurant.find(params[:id])
  # 	@restaurant.destroy
  # 	flash[:notice] = 'Restaurant deleted successfully'
  # 	redirect_to '/restaurants'
  # end



end

