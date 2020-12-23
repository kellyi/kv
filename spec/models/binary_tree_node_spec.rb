require 'rails_helper'

RSpec.describe BinaryTreeNode do
  describe '#insert' do
    let(:key) { nil }
    let(:value) { nil }
    let(:left) { nil }
    let(:right) { nil }

    subject { described_class.new(key: key, value: value, left: left, right: right) }

    context 'when the current node has a nil value for key' do
      let(:new_key) { 5 }
      let(:new_value) { 10 }

      it 'inserts the new key and value into the current node' do
        expect { subject.insert(new_key: new_key, new_value: new_value) }
          .to change { subject.key }.from(nil).to(5)
          .and change { subject.value }.from(nil).to(10)
      end
    end

    context 'when the current node has a key equal to the new_key' do
      let(:key) { 5 }
      let(:value) { 20 }
      let(:new_key) { 5 }
      let(:new_value) { 100 }

      it 'updates the value for the current node' do
        expect { subject.insert(new_key: new_key, new_value: new_value) }
          .to change { subject.value }.from(value).to(new_value)
      end
    end

    context 'when the current node has a key greater than the new_key' do
      let(:key) { 5 }
      let(:value) { 10 }
      let(:new_key) { 2 }
      let(:new_value) { 4 }

      context 'when the left node is nil' do
        it 'creates a new node to the left' do
          expect { subject.insert(new_key: new_key, new_value: new_value) }
            .to change { subject.left&.key }.from(nil).to(2)
            .and change { subject.left&.value }.from(nil).to(4)
        end
      end

      context 'when the left node is not nil' do
        let(:left) { described_class.new(key: 3, value: 6) }

        it 'creates a new node beneath the left node' do
          expect { subject.insert(new_key: new_key, new_value: new_value) }
            .to change { subject.left.left&.key }.from(nil).to(2)
            .and change { subject.left.left&.value }.from(nil).to(4)
        end
      end
    end

    context 'when the current node has a key less than the new_key' do
      let(:key) { 5 }
      let(:value) { 10 }
      let(:new_key) { 13 }
      let(:new_value) { 26 }

      context 'when the right node is not nil' do
        it 'creates a new node to the right' do
          expect { subject.insert(new_key: new_key, new_value: new_value) }
            .to change { subject.right&.key }.from(nil).to(13)
            .and change { subject.right&.value }.from(nil).to(26)
        end
      end

      context 'when the right node is not nil' do
        let(:right) { described_class.new(key: 8, value: 16) }

        it 'creates a new node beneath the right node' do
          expect { subject.insert(new_key: new_key, new_value: new_value) }
            .to change { subject.right.right&.key }.from(nil).to(13)
            .and change { subject.right.right&.value }.from(nil).to(26)
        end
      end
    end
  end

  describe '#find' do
    let(:key) { nil }
    let(:value) { nil }
    let(:left) { nil }
    let(:right) { nil }

    subject { described_class.new(key: key, value: value, left: left, right: right) }

    context 'when the current node key is nil' do
      let(:lookup_key) { 10 }

      it 'returns nil' do
        expect(subject.find(lookup_key: lookup_key)).to be_nil
      end
    end

    context 'when the current node key equals the lookup key' do
      let(:key) { 10 }
      let(:value) { 20 }
      let(:lookup_key) { 10 }

      it 'returns the value of the current node' do
        expect(subject.find(lookup_key: lookup_key)).to eq 20
      end
    end

    context 'when the current node key is greater than the lookup key' do
      let(:key) { 10 }
      let(:value) { 20 }
      let(:lookup_key) { 5 }

      context 'when the left node is nil' do
        it 'returns nill' do
          expect(subject.find(lookup_key: lookup_key)).to be_nil
        end
      end

      context 'when the left node is not nil' do
        let(:left) { described_class.new(key: 5, value: 8) }

        it 'returns what it finds from traversing the left node' do
          expect(subject.find(lookup_key: lookup_key)).to eq 8
        end
      end
    end

    context 'when the current node key is less than the lookup key' do
      let(:key) { 5}
      let(:value) { 8 }
      let(:lookup_key) { 12 }

      context 'when the right node is nil' do
        it 'returns nil' do
          expect(subject.find(lookup_key: lookup_key)).to be_nil
        end
      end

      context 'when the right node is not nil' do
        let(:right) { described_class.new(key: 12, value: 24) }

        it 'returns what it finds from traversing the right node' do
          expect(subject.find(lookup_key: lookup_key)).to eq 24
        end
      end
    end
  end
end
