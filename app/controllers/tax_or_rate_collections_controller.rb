class TaxOrRateCollectionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  before_action :set_tax_rate_collection,only: [:show, :edit, :update, :destroy]

  def index
    @tax_or_rate_collections = current_user.tax_or_rate_collections.where(status: :active)
  end

  def new
    @tax_or_rate_collection = TaxOrRateCollection.new
    @tax_or_rate_collection.build_collection_money
  end

  def create
    @tax_or_rate_collection = TaxOrRateCollection.new(tax_or_rate_collections_params)

    respond_to do |format|
      if @tax_or_rate_collection.save!
        format.html { redirect_to @tax_or_rate_collection, notice: 'Tax Or Rate was successfully created.' }
        format.json { render :show, status: :created, location: @tax_or_rate_collection }
      else
        format.html {render :new }
        format.json { render json: @tax_or_rate_collection.errors, status: :unprocessable_entity }
      end
    end

  end

  def update

  end

  def destroy
    @tax_or_rate_collection.update_attributes(status: :deleted)

    respond_to do |format|
      format.html { redirect_to tax_or_rate_collections_path, notice: 'Trade Lisence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show

  end

  private

  def set_tax_rate_collection
    @tax_or_rate_collection = TaxOrRateCollection.find(params[:id])
  end

  def tax_or_rate_collections_params
    params.require(:tax_or_rate_collection).permit(:village_name,:owners_name,:apprisal_no,:union_id,
                                                   collection_money_attributes:[:fee,:fine,:union_id])
  end



end