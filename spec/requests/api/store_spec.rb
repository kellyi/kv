require 'rails_helper'

RSpec.describe Api::StoreController do
  describe 'GET /api/store' do
    it 'returns 204' do
      get '/api/store'
      expect(response).to have_http_status 204
    end
  end
end
