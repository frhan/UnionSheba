class Api::UpazilasController < ApplicationController

  def index
    render(json: Upazila.all)
  end

  def unions
    unions = Union.where(upazila_id: params[:id])
    render(json: unions)
  end

  def show
    render(json: Upazila.find[params[:id]])
  end

end