class TradeOrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trade_organization, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @trade_organizations = TradeOrganization.where(union_id: current_user.union.id)
    end

  end

  def new
    @trade_organization = TradeOrganization.new
    @trade_organization.trade_licenses.build
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @trade_organization = TradeOrganization.new(trade_organization_params)
    respond_to do |format|
      if @trade_organization.save
        format.html { redirect_to @trade_organization, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @trade_organization }
      else
        format.html { render :new }
        format.json { render json: @trade_organization.errors, status: :unprocessable_entity }
      end
    end

  end


  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @trade_organization.update(trade_organization_params)
        format.html { redirect_to @trade_organization, notice: 'Recipe was successfully updated.' }
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
    @trade_organization.destroy
    respond_to do |format|
      format.html { redirect_to trade_organization_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def renew

  end

  private

  def set_trade_organization
    @trade_organization = TradeOrganization.find(params[:id])
  end

  def trade_organization_params
    params.require(:trade_organization).permit(:enterprize_name_in_eng,:enterprize_name_in_bng,:owners_name_eng,:owners_name_bng,
    :fathers_name,:mothers_name,:spouse_name,:village_name,:post_name,:upazilla_name,:zilla_name,:business_place,:business_category,
    :union_id,trade_licenses_attributes: [:id, :fiscal_year, :license_fee])
  end

end
