require 'rails_helper'

RSpec.describe Api::StoreController do
  describe 'GET /api/store' do
    before do
      Store.create(key: 1, value: 1)
      Store.create(key: 2, value: 2)
    end

    it 'returns all keys and values' do
      get '/api/store'
      expect(response).to have_http_status 200
      expect(JSON.parse(response.body)).to include("1" => 1, "2" => 2)
    end
  end

  describe 'POST /api/store' do
    before do
      Store.reset!
    end

    context 'when the key is not present in the Store' do
      it 'saves the key and value' do
        expect { post '/api/store?key=hello&value=world' }
          .to change { Store.all }.from({}).to('hello' => 'world')
      end
    end

    context 'when the key is present in the Store' do
      before do
        Store.create(key: 'hello', value: 'hello')
      end

      it 'returns 409' do
        post '/api/store?key=hello&value=world'
        expect(response).to have_http_status 409
      end
    end
  end
end
