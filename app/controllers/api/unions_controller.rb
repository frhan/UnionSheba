class Api::UnionsController < ApplicationController

  def index
    render(json: Union.all)
  end

  def show
    render(json: Union.find[params[:id]])
  end
end