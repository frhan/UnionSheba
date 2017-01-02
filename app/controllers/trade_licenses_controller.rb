class TradeLicensesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
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

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    trade_organization = @trade_license.trade_organization
    respond_to do |format|
      if @trade_license.update(trade_license_params)
        format.html { redirect_to  trade_organization_path(trade_organization), notice: 'Trade license was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @trade_organization.errors, status: :unprocessable_entity }
      end
    end

  end


  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    trade_organization = @trade_license.trade_organization
    @trade_license.destroy
    respond_to do |format|
      format.html { redirect_to trade_organization_path(trade_organization), notice: 'Trade License was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def set_trade_license
    @trade_license = TradeLicense.find(params[:id])
  end

  def trade_license_params
    params.require(:trade_license).permit(:fiscal_year,:license_fee,:remaining_fee,:fine_fee,:vat)
  end

end
