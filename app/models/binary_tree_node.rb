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

  def key_value
    { key => value }
  end

  def pairs # rubocop:disable Metrics/AbcSize
    return {} if key.nil?

    if left.nil? && right.nil?
      key_value
    elsif left.nil?
      key_value.merge(right.pairs)
    elsif right.nil?
      key_value.merge(left.pairs)
    else
      key_value.merge(left.pairs, right.pairs)
    end
  end

  def min
    left.nil? ? self : left.min
  end

  def delete(lookup_key:) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    return nil if key.nil?

    if leaf? && lookup_key == key
      @key = nil
      @value = nil
      @right = nil
      @left = nil
    elsif one_leaf? && lookup_key == key
      @key = left&.key || right&.key
      @value = left&.value || right&.value
      @left = nil
      @right = nil
    elsif lookup_key < key
      left&.delete(lookup_key: lookup_key)
    elsif lookup_key > key
      right&.delete(lookup_key: lookup_key)
    elsif lookup_key == key
      successor_node = inorder_successor
      @key = successor_node.key
      @value = successor_node.value
      right.delete(lookup_key: successor_node.key)
    end
  end

  def inorder_successor
    return nil if key.nil? || right.nil?

    right.min
  end

  private

  def leaf?
    left.nil? && right.nil?
  end

  def one_leaf?
    left.nil? ^ right.nil?
  end
end
