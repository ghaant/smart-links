require 'rails_helper'

RSpec.describe Smartlink, type: :model do
  let!(:user) { create :user }
  let!(:valid_params) { { slug: 'blah', user: user } }
  let!(:wrong_length_params) {
    {
      slug: 'qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq',
      user: user
    }
  }
  let!(:wrong_symbols_params) {
    {
      slug: 'blah./',
      user: user
    }
  }
  let!(:nil_params) { { slug: nil, user: user } }
  let!(:mix_cased_params) { { slug: 'QwErty', user: user } }

  describe 'validations.' do
    context 'A valid slug' do
      it do
        expect(Smartlink.new(valid_params).valid?).to be true
      end
    end

    context 'An invalid slug' do
      it do
        expect(Smartlink.new(wrong_length_params).valid?).to be false
        expect(Smartlink.new(wrong_symbols_params).valid?).to be false
      end
    end

    context 'An empty slug' do
      it do
        expect(Smartlink.new(nil_params).valid?).to be false
      end
    end

    context 'Duplicating slug' do
      it do
        Smartlink.create(valid_params)
        new_smartlink = Smartlink.create(valid_params)

        expect(new_smartlink.errors.messages[:slug].first).to eq('has already been taken')
      end
    end
  end

  describe 'callbacks.' do
    it 'downcases a mix-cased slug' do
      expect(Smartlink.create(mix_cased_params).slug).to eq(mix_cased_params[:slug].downcase)
    end
  end
end
