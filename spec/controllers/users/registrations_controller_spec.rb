require 'rails_helper'

describe Users::RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe '#new' do
    it 'render template new' do
      get :new

      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'creates user successful' do
      params = {
        user: {
          name:     'Test User',
          email:    'test@user.com',
          password: '1234567a@A'
        }
      }

      expect { post :create, params: params }
        .to change { User.count }.by(1)

      new_user = User.last
      expect(new_user.email).to eq('test@user.com')
      expect(new_user.name).to eq('Test User')
      expect(flash[:notice]).to eq 'Welcome! You have signed up successfully.'
    end

    it 'creates user unsuccessful due to password too short' do
      params = {
        user: {
          name:     'Test User',
          email:    'test@user.com',
          password: '1234'
        }
      }

      expect { post :create, params: params }
        .to_not change { User.count }
      expect(flash[:alert]).to eq 'Password is too short (minimum is 6 characters)'
    end

    it 'creates user unsuccessful due to password confirmation not match' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      params = {
        user: {
          name:                  'Test User',
          email:                 'test@user.com',
          password:              '123456',
          password_confirmation: '1234565'
        }
      }

      expect { post :create, params: params }
        .to_not change { User.count }
      expect(flash[:alert]).to eq "Password confirmation doesn't match Password"
    end
  end
end
