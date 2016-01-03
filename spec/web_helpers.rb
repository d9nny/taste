def sign_up(email, password)
	visit('/')
  click_link('REGISTER')
  fill_in('Email', with: email)
  fill_in('Password', with: password)
  fill_in('Password confirmation', with: password)
  click_button('Sign up')
end

def create_restaurant(name)
  visit '/'
  click_link 'ADD RESTAURANT'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end

def sign_out
  click_link 'SIGN OUT'
end

def leave_review (restaurant, thoughts="so so", rating='3')
	visit '/restaurants'
  click_link "review"
  fill_in "Thoughts", with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end