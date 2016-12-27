class HomeController < ApplicationController
  def index
    @citizens = Citizen.where("nid = :search or birthid = :search",
                              search: "#{params[:q]}") if params[:q].present?;
    respond_to do |format|
      format.html
      format.js
    end
  end
end
