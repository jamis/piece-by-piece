class NameServiceController < ApplicationController
  respond_to :json

  def parse
    name = Name.new(params[:name])
    respond_with name
  end
end
