require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:valid_params) {
    {
      name: 'Max Mustermann',
      email: 'blah@blah.de',
      password: 'qwerty'
    }
  }
  let!(:empty_email_params) {
    {
      name: 'Max Mustermann',
      email: nil,
      password: 'qwerty'
    }
  }
  let!(:long_email_params) {
    {
      name: 'Max Mustermann',
      email: 'qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq@blah.de',
      password: 'qwerty'
    }
  }
  let!(:wrong_email_params) {
    {
      name: 'Max Mustermann',
      email: '//..@blah.de',
      password: 'qwerty'
    }
  }
  let!(:empty_name_params) {
    {
      name: nil,
      email: 'blah@blah.de',
      password: 'qwerty'
    }
  }
  let!(:empty_password_params) {
    {
      name: 'Max Mustermann',
      email: 'blah@blah.de',
      password: nil
    }
  }
  let!(:short_password_params) {
    {
      name: 'Max Mustermann',
      email: 'blah@blah.de',
      password: 'qwe'
    }
  }
  let!(:mix_cased_email_params) {
    {
      name: 'Max Mustermann',
      email: 'BlaH@bLAh.de',
      password: 'qwerty'
    }
  }

  describe 'validations.' do
    context 'A valid parameters' do
      it do
        expect(User.new(valid_params).valid?).to be true
      end
    end

    context 'An invalid parameters' do
      it 'validates email correctly' do
        expect(User.new(empty_email_params).valid?).to be false
        expect(User.new(long_email_params).valid?).to be false
        expect(User.new(wrong_email_params).valid?).to be false
      end

      it 'validates name correctly' do
        expect(User.new(empty_name_params).valid?).to be false
      end

      it 'validates password correctly' do
        expect(User.new(empty_password_params).valid?).to be false
        expect(User.new(short_password_params).valid?).to be false
      end
    end

    context 'Duplicating email' do
      it do
        User.create(valid_params)
        new_user = User.create(valid_params)

        expect(new_user.errors.messages[:email].first).to eq('has already been taken')
      end
    end
  end

  describe 'callbacks.' do
    it 'downcases a mix-cased email' do
      expect(User.create(mix_cased_email_params).email).to eq(mix_cased_email_params[:email].downcase)
    end
  end
end
