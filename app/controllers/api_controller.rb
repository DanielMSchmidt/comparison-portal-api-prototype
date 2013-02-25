class ApiController < ApplicationController
  respond_to :json
  def root
    render nothing: true
  end
end
