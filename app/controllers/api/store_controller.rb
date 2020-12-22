class Api::StoreController < ApplicationController
  def index
    render json: Store.all
  end

  def create
    head :created if Store.create(key: key, value: value)
  rescue Store::KeyExistsError
    head :conflict
  end

  def show
    stored_value = Store.find(key: key)

    if stored_value
      render json: stored_value
    else
      head :not_found
    end
  end

  def update
    head :no_content if Store.update(key: key, value: value)
  rescue Store::KeyDoesNotExistError
    head :not_found
  end

  def destroy
    head :no_content if Store.delete(key: key)
  rescue Store::KeyDoesNotExistError
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
