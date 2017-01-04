class TaxOrRateCollectionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_tax_rate_collection,only: [:show, :edit, :update, :destroy]

  def index
    @tax_or_rate_collections = TaxOrRateCollection.all
  end

  def new
    @tax_or_rate_collection = TaxOrRateCollection.new
    @tax_or_rate_collection.build_collection_money
  end

  def create

  end

  def update

  end

  def destroy

  end

  def show

  end

  private

  def set_tax_rate_collection
    @tax_or_rate_collection = TaxOrRateCollection.find(params[:id])
  end

  def tax_or_collections_params
    params.require(:tax_or_rate_collection).permit(:village_name,owners_name,apprisal_no,
                                                   collection_money_attributes:[:fee,:remain,:fine,:vat,:union_id])
  end



end