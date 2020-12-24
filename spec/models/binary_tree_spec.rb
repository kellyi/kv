require 'rails_helper'

RSpec.describe BinaryTree do
  subject { described_class }

  before { described_class.reset! }

  describe '.all' do
    before do
      subject.create(key: 1, value: 2)
      subject.create(key: 3, value: 6)
    end

    it 'returns all keys and values' do
      expect(subject.all).to include(1 => 2, 3 => 6)
    end
  end

  describe '.reset!' do
    before do
      subject.create(key: 1, value: 2)
      subject.create(key: 3, value: 6)
    end

    it 'resets storage and removes all keys and values' do
      expect { subject.reset! }
        .to change { subject.all }.from(1 => 2, 3 => 6).to({})
    end
  end

  describe '.create!' do
    let(:key) { 3 }
    let(:value) { 10 }

    context 'when the key already exists in the tree' do
      before { subject.create(key: 3, value: 7) }

      it 'raises a KeyExistsError' do
        expect { subject.create(key: key, value: value) }
          .to raise_error BinaryTree::KeyExistsError
      end
    end

    context 'when the key does not exist in the tree' do
      it 'inserts the key-value pair' do
        expect { subject.create(key: key, value: value) }
          .to change { subject.find(key: key) }.from(nil).to(10)
      end
    end
  end

  describe '.find' do
    let(:key) { 3 }

    context 'when the key exists in the tree' do
      before { subject.create(key: 3, value: 6) }

      it 'returns the value for the key' do
        expect(subject.find(key: key)).to eq 6
      end
    end

    context 'when the key does not exist in the tree' do
      it 'returns nil' do
        expect(subject.find(key: key)).to be_nil
      end
    end
  end

  describe '.update' do
    let(:key) { 3 }
    let(:new_value) { 35 }

    context 'when the key exists in the tree' do
      before { subject.create(key: 3, value: 9) }

      it 'updates the key with the new value' do
        expect { subject.update(key: key, value: new_value) }
          .to change { subject.find(key: key) }.from(9).to(35)
      end
    end

    context 'when the key does not exist in the tree' do
      it 'raises an error' do
        expect { subject.update(key: key, value: new_value) }
          .to raise_error BinaryTree::KeyDoesNotExistError
      end
    end
  end

  describe '.delete' do
    let(:key) { 3 }

    context 'when the key exists in the tree' do
      before { subject.create(key: 3, value: 9) }

      it 'deletes the key-value pair' do
        expect { subject.delete(key: key) }
          .to change { subject.find(key: key) }.from(9).to(nil)
      end
    end

    context 'when the key does not exist in the tree' do
      it 'raises an error' do
        expect { subject.delete(key: key) }
          .to raise_error BinaryTree::KeyDoesNotExistError
      end
    end
  end
end
