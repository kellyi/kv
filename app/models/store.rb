require 'singleton'

class Store
  include Singleton

  class KeyExistsError < RuntimeError; end
  class KeyDoesNotExistError < RuntimeError; end

  @@storage = {}

  def self.all
    @@storage
  end

  def self.reset!
    @@storage = {}
  end

  def self.create(key:, value:)
    raise KeyExistsError if find(key: key)

    @@storage.update(key.to_s => value)
  end

  def self.find(key:)
    @@storage.fetch(key.to_s, nil)
  end

  def self.update(key:, value:)
    raise KeyDoesNotExistError unless find(key: key)

    @@storage.update(key.to_s => value)
  end

  def self.delete(key:)
    raise KeyDoesNotExistError unless find(key: key)

    @@storage.delete(key.to_s)
  end
end
