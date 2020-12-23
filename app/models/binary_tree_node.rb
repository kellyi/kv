class BinaryTreeNode
  attr_accessor :key, :value, :left, :right

  def initialize(key:, value:, left: nil, right: nil)
    @key = key
    @value = value
    @left = left
    @right = right
  end

  def insert(new_key:, new_value:) # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity
    if key.nil? || key == new_key
      @key = new_key
      @value = new_value
    elsif new_key < key && left.nil?
      @left = BinaryTreeNode.new(key: new_key, value: new_value)
    elsif new_key > key && right.nil?
      @right = BinaryTreeNode.new(key: new_key, value: new_value)
    elsif new_key < key
      @left.insert(new_key: new_key, new_value: new_value)
    elsif new_key > key
      @right.insert(new_key: new_key, new_value: new_value)
    end
  end

  def find(lookup_key:) # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity
    return nil if key.nil?

    if lookup_key == key
      value
    elsif lookup_key < key && left.nil?
      nil
    elsif lookup_key > key && right.nil?
      nil
    elsif lookup_key < key
      left.find(lookup_key: lookup_key)
    elsif lookup_key > key
      right.find(lookup_key: lookup_key)
    end
  end
end
