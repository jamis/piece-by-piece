class RepositoriesController < ApplicationController
  respond_to :json

  def index
    respond_with Repository.all
  end
end
