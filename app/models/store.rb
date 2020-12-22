require 'singleton'

class Store
  include Singleton

  class KeyExistsError < RuntimeError; end

  @@storage = {}

  def self.all
    @@storage
  end

  def self.reset!
    @@storage = {}
  end

  def self.create(key:, value:)
    raise KeyExistsError if find(key: key)

    @@storage.update(key => value)
  end

  def self.find(key:)
    @@storage.fetch(key, nil)
  end
end
