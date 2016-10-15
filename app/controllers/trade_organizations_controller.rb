class TradeOrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trade_organization, only: [:show, :edit, :update, :destroy,
                                                :renew,:show_money_recipt, :create_trade_license,:edit_license]

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
      format.pdf do
        render :pdf => file_name,
               :template => 'trade_organizations/show.pdf.erb',
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               :show_as_html => params[:debug].present?
      end
    end
  end

  def show_money_recipt

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

  def create_trade_license
    trade_license = TradeLicense.new(trade_license_params)
    saved = false

    if trade_license.save
      saved = true
      @trade_organization.trade_licenses.push trade_license
    end

    respond_to do |format|
      if saved
        format.html { redirect_to @trade_organization, notice: 'was successfully created.' }
        format.json { render :show, status: :created, location: @trade_organization }
      else
        format.html { render :renew }
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
    @trade_license = TradeLicense.new
  end

  def edit_license
    @trade_license = TradeLicense.find(params[:license_id])

  end

  private

  def file_name
    'trade_license'
  end

  def set_trade_organization
    @trade_organization = TradeOrganization.find(params[:id])
  end

  def trade_organization_params
    params.require(:trade_organization).permit(:enterprize_name_in_eng, :enterprize_name_in_bng, :owners_name_eng, :owners_name_bng,
                                               :fathers_name, :mothers_name, :spouse_name, :village_name, :post_name, :upazilla_name, :zilla_name, :business_place, :business_category,
                                               :union_id, trade_licenses_attributes: [:id, :fiscal_year, :license_fee])
  end

  def trade_license_params
    params.require(:trade_license).permit(:fiscal_year,:license_fee)
  end

end
