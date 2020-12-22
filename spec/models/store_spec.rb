require 'rails_helper'

RSpec.describe Store do
  before { Store.reset! }

  describe '.all' do
    subject { described_class }

    before do
      Store.create(key: :hello, value: :hello)
      Store.create(key: :world, value: :world)
    end

    it 'returns all keys and values' do
      expect(subject.all).to include('hello' => :hello, 'world' => :world)
    end
  end

  describe '.reset!' do
    subject { described_class }

    before do
      Store.create(key: :hello, value: :hello)
      Store.create(key: :world, value: :world)
    end

    it 'resets storage and removes all keys and values' do
      expect { subject.reset! }
        .to change { subject.all }.from('hello' => :hello, 'world' => :world).to({})
    end
  end

  describe '.create' do
    subject { described_class }

    context 'when the key does not exist in the Store' do
      it 'saves the key and value' do
        expect { subject.create(key: :hello, value: :world) }
          .to change { subject.all }.from({}).to('hello' => :world)
      end
    end

    context 'when the key exists in the Store' do
      before { Store.create(key: 'hello', value: :hello) }

      it 'raises an error' do
        expect { subject.create(key: :hello, value: :world) }
          .to raise_error Store::KeyExistsError
      end
    end
  end

  describe '.find' do
    subject { described_class }

    context 'when the key exists in the store' do
      before { Store.create(key: :hello, value: :world) }

      it 'returns the value' do
        expect(Store.find(key: :hello)).to eq :world
      end
    end

    context 'when the key does not exist in the store' do
      it 'returns nil' do
        expect(Store.find(key: :hello)).to be_nil
      end
    end
  end
end
