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
    expect(page).to have_content( "error")
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
        create_restaurant("KFC")
        leave_review("KFC")
        visit '/'
        click_link("KFC")
        click_link("Edit Review")
        fill_in "Toughts", with: "good"
        expect(page).to have_content("good")
      end

      scenario 'when not signed in' do
        sign_up("test@test.com", "password")
        create_restaurant("KFC")
        leave_review("KFC")
        sign_out
        sign_up("testing@testing.com", "password")
        visit '/'
        click_link("KFC")
        click_link("Edit Review")
        expect(page).to have_content("You can only edit your reviews")
      end
    end
  end
end