require 'rails_helper'

describe Users::SessionsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    it 'returns login successfully if user email exist and password correct' do
      create(:user, name: 'Test Name', email: 'test@example.com', password: '12345Aa@')
      params = {
        user: {
          email:    'test@example.com',
          password: '12345Aa@'
        }
      }
      post :create, params: params

      expect(flash[:notice]).to eq 'Signed in successfully.'
    end

    it 'returns wrong info if user email exist and password incorrect' do
      create(:user, email: 'test@example.com', password: '12345Aa@')
      params = {
        user: {
          email:    'test@example.com',
          password: '123456781'
        }
      }
      post :create, params: params

      expect(flash[:alert]).to eq 'Invalid Email or password.'
    end
  end
end

