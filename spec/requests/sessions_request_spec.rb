require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create :user }
  let!(:session_params) do
    {
      session: {
        email: user.email,
        password: user.password
      }
    }
  end

  let!(:invalid_session_params) do
    {
      session: {
        email: 'q@q.de',
        password: 'blah-blah'
      }
    }
  end

  describe 'GET /login' do
    it 'returns http success' do
      get '/login'

      expect(response).to have_http_status(:success)
    end

    it 'redirects to the curent user when the user is logged in' do
      post login_path, params: session_params
      get '/login'

      expect(response).to redirect_to(user_path(user))
    end
  end

  describe 'POST /login' do
    context 'when the user is registered' do
      it 'redirects to the user page' do
        post login_path, params: session_params

        expect(response).to redirect_to(user_path(user))
      end
    end

    context 'when the user is not registered' do
      it 'redirects to the login page' do
        post login_path, params: invalid_session_params

        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'DELETE /logout' do
    it 'redirects to the login page' do
      delete logout_path

      expect(response).to redirect_to(login_path)
    end
  end
end
