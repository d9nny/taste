class RestaurantsController < ApplicationController

  before_action :restaurant_creator?, :only => [:edit, :update, :destroy]
	before_action :authenticate_user!, :except => [:index, :show]

	def create
		if  current_user != nil
			@restaurant = Restaurant.create(restaurant_params)
	    @restaurant.user_id = current_user.id
			if @restaurant.save
				redirect_to restaurants_path
			else
				render 'new'
			end
		else
      flash[:notice] = "You aren't logged in"
      redirect_to new_user_session_path
    end
	end

	def index
		@restaurants = Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def restaurant_params
	  params.require(:restaurant).permit(:name, :image, :description)
	end

  def restaurant_creator?
    @restaurant = Restaurant.find(params[:id])
    if  current_user != nil
	    unless @restaurant.user_id == current_user.id 
	      flash[:notice] = "You aren't the restaurant creator"
	      redirect_to restaurants_path
	    end
	  else
	  	flash[:notice] = "You aren't the logged in"
	    redirect_to new_user_session_path
	  end
  end

	def show
	  @restaurant = Restaurant.find(params[:id])
	end

	def edit
		@restaurant = Restaurant.find(params[:id])
	end

	def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)

    redirect_to '/restaurants'
  end

  def destroy
  	@restaurant = Restaurant.find(params[:id])
  	@restaurant.destroy
  	flash[:notice] = 'Restaurant deleted successfully'
  	redirect_to '/restaurants'
  end

end
