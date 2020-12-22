require 'rails_helper'

RSpec.describe "Logins", type: :system do
  let!(:user) { create :user }

  before do
    driven_by(:rack_test)

    visit login_path
  end

  context 'Valid credentials' do
    it 'log in the user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.email)
    end
  end

  context 'Invalid credentials' do
    it 'shows the alert' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123'

      click_button 'Log in'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Invalid email/password combination')
    end
  end
end
