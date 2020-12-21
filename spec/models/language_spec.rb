require 'rails_helper'

RSpec.describe Language, type: :model do
  let!(:valid_params) { { code: 'en' } }
  let!(:invalid_params) { { code: 'e' } }
  let!(:de_params) { { code: 'de' } }
  let!(:nil_params) { { code: nil } }

  describe 'validations.' do
    context 'A valid language code' do
      it do
        expect(Language.new(valid_params).valid?).to be true
      end
    end

    context 'An ivalid language code' do
      it do
        expect(Language.new(invalid_params).valid?).to be false
      end
    end

    context 'An empty language code' do
      it do
        expect(Language.new(nil_params).valid?).to be false
      end
    end
  end

  describe 'callbacks.' do
    it 'makes English code default' do
      expect(Language.create(valid_params).default?).to be true
      expect(Language.create(de_params).default?).to be false
    end
  end
end
