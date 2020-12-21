require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let!(:user) { create :user }

  describe '#log_in' do
    it 'logs in the correct user' do
      log_in(user)

      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe '#log_out' do
    before {
      log_in(user)
      current_user
    }

    it 'clears the session' do
      expect(session.key?(:user_id)).to be true

      log_out

      expect(session.key?(:user_id)).to be false
    end

    it 'removes current_user' do
      expect(@current_user).to eq(user)

      log_out

      expect(@current_user).to be(nil)
    end
  end

  describe '#logged_in?' do
    before { log_in(user) }

    it do
      expect(logged_in?).to be true
    end
  end

  describe '#current_user' do
    before { log_in(user) }

    it 'returns the logged in user' do
      expect(current_user).to eq(user)
    end
  end
end
