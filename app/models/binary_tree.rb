require 'singleton'

class BinaryTree
  include Singleton

  class KeyExistsError < RuntimeError; end
  class KeyDoesNotExistError < RuntimeError; end

  @@storage = BinaryTreeNode.new(key: nil, value: nil, left: nil, right: nil)

  def self.all
    @@storage.pairs
  end

  def self.reset!
    @@storage = BinaryTreeNode.new(key: nil, value: nil, left: nil, right: nil)
  end

  def self.create(key:, value:)
    raise KeyExistsError if find(key: key)

    @@storage.insert(new_key: key, new_value: value)
  end

  def self.find(key:)
    @@storage.find(lookup_key: key)
  end

  def self.update(key:, value:)
    raise KeyDoesNotExistError unless find(key: key)

    @@storage.insert(new_key: key, new_value: value)
  end

  def self.delete(key:)
    raise KeyDoesNotExistError unless find(key: key)

    @@storage.delete(lookup_key: key)
  end
end
