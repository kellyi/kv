require 'rails_helper'

RSpec.describe Api::StoreController do
  before { Store.reset! }

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

  describe 'PUT /api/store' do
    context 'when the key is present in the Store' do
      before do
        Store.create(key: 'hello', value: 'hello')
      end

      it 'updates the key with the new value' do
        expect { put '/api/store?key=hello&value=world' }
          .to change { Store.all }.from('hello' => 'hello').to('hello' => 'world')
      end
    end

    context 'when the key is not present in the Store' do
      it 'returns 404' do
        put '/api/store?key=hello&value=world'
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'DELETE /api/store' do
    context 'when the key is present in the Store' do
      before do
        Store.create(key: 'hello', value: 'hello')
      end

      it 'updates the key with the new value' do
        expect { delete '/api/store?key=hello' }
          .to change { Store.all }.from('hello' => 'hello').to({})
      end
    end

    context 'when the key is not present in the Store' do
      it 'returns 204' do
        expect { delete '/api/store?key=hello' }
          .not_to change { Store.all }.from({})

        expect(response).to have_http_status 204
      end
    end
  end
end
