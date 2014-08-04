class SourcesController < ApplicationController
  respond_to :json

  def index
    respond_with Source.all
  end
end
