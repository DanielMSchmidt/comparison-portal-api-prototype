require 'rubygems'
require 'json'

class ApiController < ApplicationController
  before_filter :log_action
  before_filter :authenticate, except: [:root, :post_users, :post_providers, :delete_providers]

  respond_to :json
  def root
    requested_value = request.headers["isbn"] || request.headers["text"]
    unless (requested_value.nil?)
      render json: '{"id": 4,"type": "Disk","identifier": "978-3453146976", "price": [ {"provider": "ebay", "price": "12.5" }, {"provider": "buecher.de", "price": "13.7"}] }', status: :ok
    else
      render json: {}, status: :no_content
    end
  end

  def get_users
    if (@auth["username"] == "valid-user" && @auth["password"] == "valid-password")
      render json: {}, status: :accepted
    else
      render json: {}, status: :not_acceptable
    end
  end

  def post_users
    unless (params["username"].nil? || params["password"].nil?)
      render json: {}, status: :created
    else
      render json: '{"errors": [{"username": "This username already exists"},{"password": "This password is too short"}]}', status: :not_acceptable
    end
  end

  def put_users
    render json: {}, status: :accepted
  end

  def delete_users
    render json: {}, status: :accepted
  end

  def get_carts
    render json: '{"carts": [{"id": 12,"items": [{"id": 4,"type": "Disk","identifier": "978-3453146976","price": [{"provider": "ebay","price": 12.5},{"provider": "buecher.de","price": 13.7 }]},{"id": 9, "type": "Book","identifier": "978-3446237360", "price": [{"provider": "ebay","price": 32.5}]}],"total": [{ "ebay": 50}]},{"id": 42,"items": [{"id": 1, "type": "E-Book", "identifier": "978-3453446976", "price": [{"provider": "ebay", "price": 12.5},{"provider": "buecher.de","price": 13.7}]},{"id": 2,"type": "Book","identifier": "978-3455237360","price": [{"provider": "ebay","price": 322.5} ,{"provider": "buecher.de","price": 123.7}]}],"total": [{"ebay": 500},{"buecher.de": 600}]}]}', status: :ok
  end

  def post_carts
    render json: '{ "id": 1337, "items": [], "total": []}', status: :created
  end

  def put_carts
    unless (params["item_id"].nil?)
      render json: {}, status: :accepted
    else
      render json: {}, status: :ok
    end
  end

  def delete_carts
    if (params["id"].to_i == 37)
      render json: {}, status: :accepted
    else
      render json: {}, status: :not_found
    end
  end

  def get_providers
    render json: '[{"ebay": "active"},{"buecher.de": "inactive"}]', status: :accepted
  end

  def post_providers
    render json: {}, status: :bad_request
  end

  def put_providers
    render json: {}, :accepted
  end

  def delete_providers
    render json: {}, status: :bad_request
  end

  protected

  def log_action
    logger.info "Controller: API, Action: #{params[:action]}"
    logger.info "Params: #{params.to_s}"
  end

  def authenticate
    authentication = request.headers["authentication"]
    unless authentication.nil?
      @auth = JSON.parse(authentication)
    else
      render json: {}, status: :no_content
    end
  end

end
