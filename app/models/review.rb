class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: {scope: :restaurant, message: "Only one review per restaurant"}
  has_many :endorsements

  def get_time
  	return created_at
  end
end
