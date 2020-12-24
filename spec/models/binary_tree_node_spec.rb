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
      let(:key) { 5 }
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

  describe '#key_value' do
    subject { described_class.new(key: 10, value: 20) }

    it 'returns a dictionary pairing the key and the value' do
      expect(subject.key_value).to eq({ 10 => 20 })
    end
  end

  describe '#pairs' do
    subject do
      described_class.new(key: 10,
                          value: 20,
                          left: described_class.new(key: 4,
                                                    value: 8),
                          right: described_class.new(key: 15,
                                                     value: 30))
    end

    it 'returns a dictionary containing all the key value pairs' do
      expect(subject.pairs).to eq({ 10 => 20, 4 => 8, 15 => 30 })
    end
  end

  describe '#min' do
    let(:minimum_node) { described_class.new(key: 4, value: 8) }
    subject do
      described_class.new(key: 10,
                          value: 20,
                          left: minimum_node,
                          right: described_class.new(key: 15,
                                                     value: 30))
    end

    it 'returns the node with the smallest key in the tree' do
      expect(subject.min).to eq minimum_node
    end
  end

  describe '#inorder_successor' do
    let(:successor) { described_class.new(key: 13, value: 26) }
    subject do
      described_class.new(key: 10,
                          value: 20,
                          right: described_class.new(key: 15,
                                                     value: 30,
                                                     left: successor))
    end

    it 'returns the inorder successor node' do
      expect(subject.inorder_successor).to eq successor
    end
  end

  describe '#delete' do
    let(:key_to_delete) { 10 }

    context 'when the node key is nil' do
      subject { described_class.new(key: nil, value: nil) }

      it 'returns nil' do
        expect(subject.delete(lookup_key: key_to_delete)).to be_nil
      end
    end

    context 'when the node is a leaf and it has a key equal to the lookup key' do
      subject { described_class.new(key: 10, value: 10) }

      it 'deletes the key-value pair' do
        expect { subject.delete(lookup_key: key_to_delete) }
          .to change { subject.key }.from(10).to(nil)
          .and change { subject.value }.from(10).to(nil)
      end
    end

    context 'when the node has one leaf and has a key equal to the lookup key' do
      subject do
        described_class.new(key: 10,
                            value: 20,
                            left: described_class.new(key: 8,
                                                      value: 16))
      end

      it 'deletes the key-value pair and promotes a new node' do
        expect { subject.delete(lookup_key: key_to_delete) }
          .to change { subject.key }.from(10).to(8)
          .and change { subject.value }.from(20).to(16)
      end
    end

    context 'when the node has multiple leaves' do
      let(:key_to_delete) { 15 }
      let(:successor) { described_class.new(key: 16, value: 32) }

      subject do
        described_class.new(key: 15,
                            value: 30,
                            left: described_class.new(key: 8,
                                                      value: 16),
                            right: described_class.new(key: 20,
                                                       value: 40,
                                                       left: successor))
      end

      it 'deletes the key-value pair and promotes the inorder successor node' do
        expect { subject.delete(lookup_key: key_to_delete) }
          .to change { subject.key }.from(15).to(16)
          .and change { subject.value }.from(30).to(32)
          .and change { subject.right.find(lookup_key: 16) }.from(32).to(nil)
      end
    end

    context 'when the key is not in the tree' do
      subject do
        described_class.new(key: 15,
                            value: 30,
                            left: described_class.new(key: 8,
                                                      value: 16),
                            right: described_class.new(key: 20,
                                                       value: 40))
      end

      it 'returns nil' do
        expect(subject.delete(lookup_key: key_to_delete)).to be_nil
      end
    end
  end
end
