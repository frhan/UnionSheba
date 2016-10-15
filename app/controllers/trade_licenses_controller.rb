class TradeLicensesController < ApplicationController
  before_action :authenticate_user!

  def show

  end

  def new
    @trade_license = TradeLicense.new
  end

  def create

  end

  private

  def set_trade_organization
    @trade_organization = TradeOrganization.find(params[:trade_organization_id])
  end

  def trade_license_params
    params.require(:trade_license).permit(:fiscal_year,:license_fee)
  end

end
