class TradeLicensesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_trade_license, only: [:show, :edit, :update, :destroy]

  def show

  end

  def new
    @trade_license = TradeLicense.new
  end

  def create

  end

  # GET /recipes/1/edit
  def edit
  end


  private

  def set_trade_license
    @trade_license = TradeLicense.find(params[:id])
  end

  def trade_license_params
    params.require(:trade_license).permit(:fiscal_year,:license_fee)
  end

end
