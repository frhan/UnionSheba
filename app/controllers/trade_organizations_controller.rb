class TradeOrganizationsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource :only => :print_money_recipt
  before_action :set_trade_organization, only: [:show, :edit, :update, :destroy,
                                                :renew,:show_money_recipt,
                                                :create_trade_license,:edit_license]

  def index
    respond_to do |format|
      format.html
      format.json { render json: TradeOrganizationDatatable.new(view_context,current_user) }
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
               :show_as_html => params[:debug].present?,
               margin:  {   top:               0,                     # default 10 (mm)
                            bottom:            0,
                            left:              20,
                            right:             0 },
               dpi:                            '300'
               #zoom: 1.17647
      end
    end
  end

  def print_money_recipt
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => money_recipt_file_name,
               :template => 'trade_organizations/print_money_recipt.pdf.erb',
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               :show_as_html => params[:debug].present?,
               margin:  {   top:               0,                     # default 10 (mm)
                            bottom:            0,
                            left:              10,
                            right:             0 },
               dpi:                            '300'
        #zoom: 1.17647
      end
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
        format.html { redirect_to @trade_organization, notice: 'Trade License was successfully created.' }
        format.json { render :show, status: :created, location: @trade_organization }
      else
        format.html {render :new }
        format.json { render json: @trade_organization.errors, status: :unprocessable_entity }
      end
    end

  end

  def create_trade_license
    @trade_license = TradeLicense.new(trade_license_params)
    @trade_organization.trade_licenses.push @trade_license

    respond_to do |format|
      if @trade_license.save
        format.html { redirect_to @trade_organization, notice: 'was successfully created.' }
        format.json { render :show, status: :created, location: @trade_organization }
      else
        format.html { render :renew }
        format.json { render json: @trade_organization.errors, status: :unprocessable_entity }
      end
    end

  end

  def update_trade_license

  end


  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @trade_organization.update(trade_organization_params)
        format.html { redirect_to @trade_organization, notice: 'Trade License was successfully updated.' }
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
    @trade_organization.update_attributes(status: :deleted)

    respond_to do |format|
      format.html { redirect_to trade_organizations_url, notice: 'Trade Lisence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def renew
    @trade_license = TradeLicense.new
  end

  def edit_license
    @trade_license = TradeLicense.find(params[:license_id])
  end

  def update_issue_date
    #TODO: ajax for update issue date
  end

  private

  def file_name
    pdf_file_name 'trade_license_' << @trade_organization.union_code
  end

  def money_recipt_file_name
    pdf_file_name 'money_recipt_' << @trade_organization.union_code
  end

  def set_trade_organization
    @trade_organization = TradeOrganization.find(params[:id])
  end

  def trade_organization_params
    params.require(:trade_organization).permit(:enterprize_name_in_eng, :enterprize_name_in_bng,
                                               :owners_name_eng, :owners_name_bng,
                                               :fathers_name, :mothers_name, :spouse_name,
                                               :village_name, :post_name, :upazilla_name,:word_no,
                                               :zilla_name, :business_place, :business_category,:holding_no,
                                               :union_id, trade_licenses_attributes:
                                                   [:fiscal_year,:license_fee,:remaining_fee,:fine_fee])
  end

  def trade_license_params
    params.require(:trade_license).permit(:fiscal_year,:license_fee,:remaining_fee,:fine_fee)
  end

end
