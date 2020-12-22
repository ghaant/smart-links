require 'rails_helper'

RSpec.describe Redirection, type: :model do
  let!(:language) { create :language }
  let!(:smartlink) { create :smartlink }
  let!(:valid_params) { { url: 'https://www.youtube.com/', language: language, smartlink: smartlink } }
  let!(:invalid_params) { { url: 'blah', language: language, smartlink: smartlink } }
  let!(:nil_params) { { url: nil, language: language, smartlink: smartlink } }

  describe 'validations.' do
    context 'A valid url' do
      it do
        expect(Redirection.new(valid_params).valid?).to be true
      end
    end

    context 'An invalid url' do
      it do
        expect(Redirection.new(invalid_params).valid?).to be false
      end
    end

    context 'An empty url' do
      it do
        expect(Redirection.new(nil_params).valid?).to be false
      end
    end
  end
end
