require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  before do
    user = create(:user)
    allow(controller).to receive_messages(authenticate_user!: true, current_user: user)
  end

  describe '#GET index' do
    it 'returns links page' do
      get :index

      expect(response.status).to eq(200)
    end
  end

  describe '#POST create' do
    it 'shorten url successful' do
      user = create(:user)
      valid_url = Faker::Internet.url
      post :create, params: { link: { url: valid_url, user: user }, format: :turbo_stream }

      expect(response.status).to eq(200)
      expect(Link.last.url).to eq(valid_url)
    end

    it 'shorten url failed' do
      user = create(:user)
      invalid_url = 'invalid_url'
      post :create, params: { link: { url: invalid_url, user: user } }

      expect(response.status).to eq(422)
      expect(Link.count).to be_zero
      expect(flash[:alert]).to eq('Url is invalid')
    end
  end

  describe '#PUT update' do
    it 'update link successful' do
      link = create(:link, url: 'https://google.com/abc', shorten_code: 'abcd1234', user_id: User.first.id)
      put :update, params: { link: { shorten_code: 'qwert123' }, id: link.id }

      expect(Link.last.shorten_code).to eq('qwert123')
      expect(flash[:notice]).to eq('Update link successful')
    end

    it 'update link failed' do
      link = create(:link, url: 'https://google.com/abc', shorten_code: 'abcd1234', user_id: User.first.id)
      put :update, params: { link: { shorten_code: 'abc' }, id: link.id }

      expect(response.status).to eq(422)
      expect(flash[:alert]).to eq('Shorten code is too short (minimum is 6 characters)')
    end
  end

  describe '#DELETE link' do
    it 'should delete succesful' do
      link = create(:link, user_id: User.first.id)
      expect do
        delete :destroy, params: { id: link.id }
      end.to change { Link.count }.by(-1)

      expect(flash[:notice]).to eq('Link was successfully destroyed.')
    end
  end
end
