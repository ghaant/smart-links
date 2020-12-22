require 'rails_helper'

RSpec.describe "Smartlinks", type: :request do
  let!(:smartlink) { create :smartlink }
  let!(:en_language) { create :language, code: 'en'}
  let!(:de_language) { create :language, code: 'de'}
  let!(:ru_language) { create :language, code: 'ru'}
  let!(:en_redirection) { create :redirection, smartlink: smartlink, language: en_language, url: 'https://www.youtube.com/' }
  let!(:de_redirection) { create :redirection, smartlink: smartlink, language: de_language, url: 'https://www.dw.com/' }

  let!(:smartlink2) { create :smartlink }

  describe 'GET /redirect/*slug' do
    context 'when a valig slug is provided' do
      context 'when the slug exists' do
        context 'when a redirections for the browser language exists' do
          it 'redirects to the url set for the specific slug and languge' do
            Rails.application.env_config['HTTP_ACCEPT_LANGUAGE'] = "#{de_language.code}_qwerty"
            get "/smartlinks/#{smartlink.slug}"

            expect(response).to redirect_to(de_redirection.url)
          end
        end

        context 'when a redirections for the browser language does not exists' do
          it 'redirects to the URL for the default language' do
            Rails.application.env_config['HTTP_ACCEPT_LANGUAGE'] = 'ru_qwerty'
            get "/smartlinks/#{smartlink.slug}"

            expect(response).to redirect_to(en_redirection.url)
          end
        end

        context 'when there is no redirection for the browser language and for the default one' do
          it 'redirects to the list with all smartlinks' do
            get "/smartlinks/#{smartlink2.slug}"

            expect(response).to redirect_to(smartlinks_path)
          end
        end
      end

      context 'when the slug does not exist' do
        it 'redirects to the list with all smartlinks' do
          get '/smartlinks/blah-blah'

          expect(response).to redirect_to(smartlinks_path)
        end
      end
    end

    context 'when an invalig slug is provided' do
      it 'redirects to the list with all smartlinks' do
        get '/smartlinks/qwer/.+'

        expect(response).to redirect_to(smartlinks_path)
      end
    end
  end
end
