class TradeOrganizationController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def new

  end

  def create

  end

  def renew

  end

  private
  def trade_organization_params
    params.require(:trade_organization).permit(:name)
  end

end
