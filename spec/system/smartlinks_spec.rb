require 'rails_helper'

RSpec.describe "Smartlinks", type: :system do
  let!(:user) { create :user }
  let!(:smartlink) { create :smartlink }

  before do
    driven_by(:rack_test)
  end

  context 'when user is logged in' do
    before do
      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
    end

    it "lists users's smartlinks" do
      visit smartlinks_path

      expect(current_path).to eq(smartlinks_user_path(user))
      expect(page).to have_content('Create a smartlink')
      expect(page).to have_content('Back')
    end

    context 'creating a new smartlink' do
      before do
        visit smartlinks_user_path(user)

        click_on 'Create a smartlink'
      end

      context 'valid params' do
        it 'creates a smartlink' do
          fill_in 'Slug', with: 'slug_name'
          fill_in 'Language code', with: 'de'
          fill_in 'smartlink_url', with: 'https://www.youtube.com/'

          click_button 'Create Smartlink'

          expect(current_path).to eq(smartlinks_user_path(user))
          expect(page).to have_content('Smartlink was successfully created.')
        end
      end

      context 'invalid params' do
        context 'a blank slug' do
          it 'shows error messages' do
            fill_in 'Slug', with: ''
            fill_in 'Language code', with: 'de'
            fill_in 'smartlink_url', with: 'https://www.youtube.com/'

            click_button 'Create Smartlink'

            expect(page).to have_content('A slug could not be blank.')
          end
        end

        context 'a wrong language code' do
          it 'shows error messages' do
            fill_in 'Slug', with: 'blah'
            fill_in 'Language code', with: 'deutch'
            fill_in 'smartlink_url', with: 'https://www.youtube.com/'

            click_button 'Create Smartlink'

            expect(page).to have_content('Please enter a 2-symbol language code.')
          end
        end

        context 'a blank URL' do
          it 'shows error messages' do
            fill_in 'Slug', with: 'blah'
            fill_in 'Language code', with: 'de'
            fill_in 'smartlink_url', with: ''

            click_button 'Create Smartlink'

            expect(page).to have_content('URL could not be blank.')
          end
        end

        context 'a smartlink with such slug already exists' do
          it 'shows error messages' do
            fill_in 'Slug', with: smartlink.slug
            fill_in 'Language code', with: 'de'
            fill_in 'smartlink_url', with: 'https://www.youtube.com/'

            click_button 'Create Smartlink'

            expect(page).to have_content('1 error prohibited this smartlink from being saved:')
          end
        end
      end
    end

    it 'deletes a smartlink' do
      visit smartlinks_user_path(user)

      click_on 'Create a smartlink'

      fill_in 'Slug', with: 'slug_name'
      fill_in 'Language code', with: 'de'
      fill_in 'smartlink_url', with: 'https://www.youtube.com/'

      click_button 'Create Smartlink'

      click_on 'Delete'

      expect(current_path).to eq(smartlinks_user_path(user))
      expect(page).to have_content('Smartlink deleted')
    end
  end

  context 'when user is not logged in' do
    it "lists all smartlinks" do
      visit smartlinks_path

      expect(current_path).to eq(smartlinks_path)
      expect(page).to have_content('Smartlinks')
      expect(page).to have_content('Log in')
    end
  end
end
