class Api::DivisionsController < ApplicationController

  def index
    render(json: Division.all)
  end

  def districts
    districts = District.where(division_id: params[:id])
    render(json: districts)
  end

  def show
    render(json: Division.find[params[:id]])
  end

end