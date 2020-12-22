require 'rails_helper'

RSpec.describe "Smartlinks", type: :request do
  let!(:user) { create :user }
  let!(:smartlink) { create :smartlink, user: user }
  let!(:en_language) { create :language, code: 'en' }
  let!(:de_language) { create :language, code: 'de' }
  let!(:ru_language) { create :language, code: 'ru' }
  let!(:en_redirection) { create :redirection, smartlink: smartlink, language: en_language, url: 'https://www.youtube.com/' }
  let!(:de_redirection) { create :redirection, smartlink: smartlink, language: de_language, url: 'https://www.dw.com/' }

  let!(:smartlink2) { create :smartlink }

  let!(:session_params) do
    {
      session: {
        email: user.email,
        password: user.password
      }
    }
  end

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

  describe 'GET /smartlinks' do
    context 'when the user is logged in' do
      it "redirects to user''s smartinks" do
        post login_path, params: session_params
        get '/smartlinks'

        expect(response).to redirect_to(smartlinks_user_path(user))
      end
    end

    context 'when the user is not logged in' do
      it 'renders a successful response' do
        get '/smartlinks'

        expect(response).to be_successful
      end
    end
  end

  describe 'POST /smartlinks' do
    context 'the user is loggeg in' do
      before { post login_path, params: session_params }

      context 'invalid parameters' do
        it 'redirects to the New smartlink page' do
          post '/smartlinks', params: { smartlink: { slug: '', language_code: 'de', url: 'https://www.dw.com/' } }
          expect(response).to redirect_to(new_smartlink_path)

          post '/smartlinks', params: { smartlink: { slug: 'blah', language_code: 'qwe', url: 'https://www.dw.com/' } }
          expect(response).to redirect_to(new_smartlink_path)

          post '/smartlinks', params: { smartlink: { slug: 'blah', language_code: 'de', url: '' } }
          expect(response).to redirect_to(new_smartlink_path)
        end
      end

      context 'valid parameters' do
        subject { post '/smartlinks', params: { smartlink: { slug: smartlink.slug, language_code: de_language.code, url: 'https://www.dw.com/' } } }

        it 're-renders the New smartlink page when the slug is duplicating' do
          expect(subject).to render_template('smartlinks/new')
        end

        it 'creates a new smartlink' do
          expect do
            post '/smartlinks', params: { smartlink: { slug: 'blah', language_code: 'de', url: 'https://www.dw.com/' } }
          end.to change(Smartlink, :count).by(1)
        end

        it "redirects to user''s smartinks" do
          post '/smartlinks', params: { smartlink: { slug: 'blah', language_code: 'de', url: 'https://www.dw.com/' } }

          expect(response).to redirect_to(smartlinks_user_path(user))
        end
      end
    end

    context 'the user is not loggeg in' do
      it 'redirects to the login page' do
        post '/smartlinks'

        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'DELETE /smartlinks/:id' do
    subject { delete "/smartlinks/#{smartlink.id}" }

    context 'the user is logged in' do
      before { post login_path, params: session_params }

      it 'deletes the smartlink' do
        expect { subject }.to change(Smartlink, :count).by(-1)
      end

      it "redirects to user''s smartinks" do
        subject

        expect(response).to redirect_to(smartlinks_user_path(user))
      end
    end

    context 'the user is not logged in' do
      it 'redirects to the login page' do
        subject

        expect(response).to redirect_to(login_path)
      end
    end
  end
end
