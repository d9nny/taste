require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up("test@test.com", "password")
    create_restaurant("KFC")
    leave_review("KFC")
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
	
  scenario 'user can only leave one review per restaurants' do
    sign_up("test@test.com", "password")
    create_restaurant("KFC")
    leave_review("KFC")
    leave_review("KFC")
    expect(page).to have_content( "Only one review per user")
  end

  context 'users can only delete or edit their own reviews' do
    # context '#delete' do
    #   scenario 'when signed in' do
    #     sign_up("test@test.com", "password")
    #     create_restaurant("KFC")
    #     leave_review("KFC")
    #     click_button("")
    #   end

    #   scenario 'when not signed in' do

    #   end
    # end

    context '#edit' do
      scenario 'when signed in' do
        sign_up("test@test.com", "password")
    #     create_restaurant("KFC")
    #     leave_review("KFC")
    #     click_button("")
      end

      scenario 'when not signed in' do
      end
    end
  end
end