class  Api::DistrictsController < ApplicationController

  def index
    render(json: District.all)
  end

  def upazilas
    upazilas = Upazila.where(district_id: params[:id])
    render(json: upazilas)
  end

  def show
    render(json: District.find[params[:id]])
  end
end