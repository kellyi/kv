class Api::BinaryTreeController < ApplicationController
  def index
    render json: BinaryTree.all
  end

  def create
    head :created if BinaryTree.create(key: key, value: value)
  rescue BinaryTree::KeyExistsError
    head :conflict
  end

  def show
    stored_value = BinaryTree.find(key: key)

    if stored_value
      render json: stored_value
    else
      head :not_found
    end
  end

  def update
    head :no_content if BinaryTree.update(key: key, value: value)
  rescue BinaryTree::KeyDoesNotExistError
    head :not_found
  end

  def destroy
    head :no_content if BinaryTree.delete(key: key)
  rescue BinaryTree::KeyDoesNotExistError
    head :no_content
  end

  private

  def key
    params.fetch(:key)
  end

  def value
    params.fetch(:value)
  end
end
