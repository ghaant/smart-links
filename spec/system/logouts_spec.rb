require 'rails_helper'

RSpec.describe "Logouts", type: :system do
  let!(:user) { create :user }

  before do
    driven_by(:rack_test)
  end

  it 'log outs the user' do
    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(current_path).to eq(user_path(user))

    click_on 'Log out'

    expect(current_path).to eq(login_path)
  end
end
