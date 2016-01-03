require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'ADD RESTAURANT'
    end
  end

  context 'restaurants have been added' do
	  before do
	    Restaurant.create(name: 'KFC')
	  end
	  scenario 'display restaurants' do
	    visit '/'
	    expect(page).to have_content('KFC')
	    expect(page).not_to have_content('No restaurants yet')
	  end
	end

	context 'creating restaurants' do

		scenario 'not signed in' do
			visit '/'
			click_link 'ADD RESTAURANT'
			expect(page).to have_content 'Log in'
		end

	  scenario 'signed in' do
	  	sign_up('test@example.com', 'testtest')
			create_restaurant('KFC')
      expect(page).to have_css 'h2', text: 'KFC'
	  end

	  context 'an invalid restaurant' do
	    it 'does not let you submit a name that is too short' do
	      sign_up('test@example.com', 'testtest')
				create_restaurant('kf')
	      expect(page).not_to have_css 'h2', text: 'kf'
	      expect(page).to have_content 'error'
	    end
	  end
	end

	context 'viewing restaurants' do

	  let!(:kfc){Restaurant.create(name:'KFC')}

	  scenario 'lets a user view a restaurant' do
	    visit '/'
	    click_link 'KFC'
	    expect(page).to have_content 'KFC'
	    expect(current_path).to eq "/restaurants/#{kfc.id}"
	  end

	end

	context 'editing restaurants' do

	  scenario 'when signed in as the creator' do
	  	sign_up('test@example.com', 'testtest')
	  	create_restaurant('KFC')
	    visit '/'
	    click_link 'edit'
	    fill_in 'Name', with: 'Kentucky Fried Chicken'
	    click_button 'Update Restaurant'
	    expect(page).to have_content 'Kentucky Fried Chicken'
	    expect(current_path).to eq '/restaurants'
	  end

	  scenario 'when not signed in as the creator' do
	  	sign_up('test@example.com', 'testtest')
	  	create_restaurant('KFC')
	  	sign_out
	  	sign_up('another@another.com', 'anotheranother')
	  	click_link 'edit'
	  	expect(page).to have_content "You aren't the restaurant creator"
	  end

	  scenario 'when not signed in' do
	  	visit '/'
	  	expect(page).not_to have_content('Edit KFC')
	  end
	end

	context 'deleting restaurants' do

		scenario 'when signed in as the creator' do
			sign_up('test@example.com', 'testtest')
			create_restaurant('KFC');
			visit '/restaurants'
			click_link 'delete'
			expect(page).not_to have_content('KFC')
			expect(page).to have_content('Restaurant deleted successfully')
		end

		scenario 'when not signed in as the creator' do
			sign_up('test@example.com', 'testtest')
			create_restaurant('KFC');
			sign_out
			sign_up('another@another.com', 'anotheranother')
			visit '/restaurants'
			click_link 'delete'
			expect(page).to have_content('KFC')
			expect(page).to have_content("You aren't the restaurant creator")
		end
	end
end















