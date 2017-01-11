class TaxOrRateCollectionsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  before_action :set_tax_rate_collection,only: [:show, :edit, :update, :destroy]

  def index
    # @tax_or_rate_collections = current_user.tax_or_rate_collections.where(status: :active)
    respond_to do |format|
      format.html
      format.json { render json: TaxOrRateCollectionDatatable.new(view_context,current_user) }
    end

  end

  def new
    @tax_or_rate_collection = TaxOrRateCollection.new
    @tax_or_rate_collection.build_collection_money
  end

  def create
    @tax_or_rate_collection = TaxOrRateCollection.new(tax_or_rate_collections_params)

    respond_to do |format|
      if @tax_or_rate_collection.save
        format.html { redirect_to @tax_or_rate_collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @tax_or_rate_collection }
      else
        format.html {render :new }
        format.json { render json: @tax_or_rate_collection.errors, status: :unprocessable_entity }
      end
    end

  end

  def update

    respond_to do |format|
      if @tax_or_rate_collection.update(tax_or_rate_collections_params)
        format.html { redirect_to @tax_or_rate_collection, notice: 'Collection  was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @tax_or_rate_collection.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @tax_or_rate_collection.update_attributes(status: :deleted)

    respond_to do |format|
      format.html { redirect_to tax_or_rate_collections_path, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => file_name,
               :template => 'tax_or_rate_collections/show.pdf.erb',
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               :show_as_html => params[:debug].present?,
               margin:  {   top:               10,                     # default 10 (mm)
                            bottom:            0,
                            left:              12,
                            right:             12},
               dpi:                            '300'
        #zoom: 1.17647
      end
    end

  end

  private

  def set_tax_rate_collection
    @tax_or_rate_collection = TaxOrRateCollection.find(params[:id])
  end

  def tax_or_rate_collections_params
    params.require(:tax_or_rate_collection).permit(:owners_name_in_english,:village_name,:owners_name,:apprisal_no,:union_id,
                                                   collection_money_attributes:[:fee,:fine,:union_id])
  end


  def file_name
    pdf_file_name 'tax_or_rate_' << @tax_or_rate_collection.union_code
  end

end