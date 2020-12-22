require 'rails_helper'

RSpec.describe "SignUps", type: :system do
  before do
    driven_by(:rack_test)

    visit new_user_path
  end

  context 'Valid parameters' do
    it 'signs up a user' do
      expect do
        fill_in 'Name', with: 'Max'
        fill_in 'Email', with: 'q@q.q'
        fill_in 'Password', with: 'test123'
        fill_in 'Confirmation', with: 'test123'

        click_button 'Create User'
      end.to change(User, :count).by(1)

      expect(current_path).to eq(login_path)
      expect(page).to have_content('User was successfully created.')
    end
  end

  context 'Invalid parameters' do
    it 'render the error messages' do
      expect do
        fill_in 'Name', with: ''
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        fill_in 'Confirmation', with: ''

        click_button 'Create User'
      end.to_not change(User, :count)

      expect(page).to have_content('5 errors prohibited this user from being saved:')
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content('Email is invalid')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content('Password is too short (minimum is 6 characters)')
    end
  end
end
