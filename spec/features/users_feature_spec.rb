require 'rails_helper'

feature "User can sign in and out" do
  context "user not sign in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('SIGN IN')
      expect(page).to have_link('REGISTER')
    end

    it "should not see a 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('SIGN OUT')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('REGISTER')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see a 'Sign out' link" do
      visit('/')
      expect(page).to have_link('SIGN OUT')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('SIGN IN')
      expect(page).not_to have_link('REGISTER')
    end
  end
end