require 'spec_helper'

describe Review, type: :model do
  it {is_expected.to belong_to :restaurant }

  it "is invalid if the rating is more than 5" do
  	review = Review.new(rating: 10)
  	expect(review).to have(1).error_on(:rating)
  end

  context "#get_time" do
    it 'get the time of review' do
      restaurant = Restaurant.create(name: 'KFC')
      this_review = restaurant.reviews.create(rating: 4)
      expect(this_review.get_time).to eq (this_review.created_at)
    end
  end
end
