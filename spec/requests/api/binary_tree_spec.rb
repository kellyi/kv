require 'rails_helper'

RSpec.describe Api::BinaryTreeController do
  before { BinaryTree.reset! }

  describe 'GET /api/binary_tree' do
    before do
      BinaryTree.create(key: 1, value: 1)
      BinaryTree.create(key: 2, value: 2)
    end

    it 'returns all keys and values' do
      get '/api/binary_tree'
      expect(response).to have_http_status 200
      expect(JSON.parse(response.body)).to include("1" => 1, "2" => 2)
    end
  end

  describe 'POST /api/binary_tree' do
    context 'when the key is not present in the BinaryTree' do
      it 'saves the key and value' do
        expect { post '/api/binary_tree?key=hello&value=world' }
          .to change { BinaryTree.all }.from({}).to('hello' => 'world')
      end
    end

    context 'when the key is present in the Binary_Tree' do
      before do
        BinaryTree.create(key: 'hello', value: 'hello')
      end

      it 'returns 409' do
        post '/api/binary_tree?key=hello&value=world'
        expect(response).to have_http_status 409
      end
    end
  end

  describe 'PUT /api/binary_tree' do
    context 'when the key is present in the Binary_Tree' do
      before do
        BinaryTree.create(key: 'hello', value: 'hello')
      end

      it 'updates the key with the new value' do
        expect { put '/api/binary_tree?key=hello&value=world' }
          .to change { BinaryTree.all }.from('hello' => 'hello').to('hello' => 'world')
      end
    end

    context 'when the key is not present in the Binary_Tree' do
      it 'returns 404' do
        put '/api/binary_tree?key=hello&value=world'
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'DELETE /api/binary_tree' do
    context 'when the key is present in the Binary_Tree' do
      before do
        BinaryTree.create(key: 'hello', value: 'hello')
      end

      it 'updates the key with the new value' do
        expect { delete '/api/binary_tree?key=hello' }
          .to change { BinaryTree.all }.from('hello' => 'hello').to({})
      end
    end

    context 'when the key is not present in the Binary_Tree' do
      it 'returns 204' do
        expect { delete '/api/binary_tree?key=hello' }
          .not_to change { BinaryTree.all }.from({})

        expect(response).to have_http_status 204
      end
    end
  end
end
