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
    raise KeyExistsError if find(key: key.to_s)

    @@storage.update(key.to_s => value)
  end

  def self.find(key:)
    @@storage.fetch(key.to_s, nil)
  end
end
