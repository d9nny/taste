class RestaurantsController < ApplicationController

def create
	Restaurant.create(restaurant_params)
	redirect_to '/restaurants'
end 

def index
	@restaurants = Restaurant.all
end

def new
	puts params
end

def restaurant_params
  params.require(:restaurant).permit(:name)
end

end
