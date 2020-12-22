require 'rails_helper'

RSpec.describe '/users', type: :request do
  let!(:user) { create :user }

  let!(:session_params) do
    {
      session: {
        email: user.email,
        password: user.password
      }
    }
  end

  let(:valid_attributes) do
    {
      name: 'Max Mustermann',
      email: 'max@gmail.de',
      password: 'qqqqqq',
      password_confirmation: 'qqqqqq'
    }
  end

  let(:invalid_attributes) do
    {
      name: 'Max Mustermann',
      email: '',
      password: 'qqqqqq',
      password_confirmation: 'qqqqqq'
    }
  end

  describe 'GET /show' do
    context 'the user is logged in' do
      it 'renders a successful response' do
        post login_path, params: session_params
        get user_url(user)

        expect(response).to be_successful
      end
    end

    context 'the user is not logged in' do
      it 'redirects to the login page' do
        get user_url(user)

        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_url

      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post users_url, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post users_url, params: { user: valid_attributes }

        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context 'with invalid parameters' do
      subject { post users_url, params: { user: invalid_attributes } }

      it 'does not create a new User' do
        expect { subject }.to change(User, :count).by(0)
      end

      it 'redners the New template' do
        post users_url, params: { user: invalid_attributes }

        expect(response).to be_successful
        expect(subject).to render_template('users/new')
      end
    end
  end

  describe 'GET /smartlinks' do
    it 'renders a successful response' do
      post login_path, params: session_params
      get smartlinks_user_url(user)

      expect(response).to be_successful
    end
  end
end
