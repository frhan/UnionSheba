class OthersCollectionsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  before_action :set_others_collection,only: [:show, :edit, :update, :destroy]

  def index
    # @others_collections = current_user.others_collections.where(status: :active)
    respond_to do |format|
      format.html
      format.json { render json: OthersCollectionDatatable.new(view_context,current_user) }
    end

  end

  def new
    @others_collection = OthersCollection.new
    @others_collection.build_collection_money
  end

  def create
    @others_collection = OthersCollection.new(others_collections_params)

    respond_to do |format|
      if @others_collection.save!
        format.html { redirect_to @others_collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @others_collection }
      else
        format.html {render :new }
        format.json { render json: @others_collection.errors, status: :unprocessable_entity }
      end
    end

  end

  def update

    respond_to do |format|
      if @others_collection.update(others_collections_params)
        format.html { redirect_to @others_collection, notice: 'Collection  was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @others_collection.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @others_collection.update_attributes(status: :deleted)

    respond_to do |format|
      format.html { redirect_to others_collections_path, notice: 'Trade Lisence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => file_name,
               :template => 'others_collections/show.pdf.erb',
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

  def set_others_collection
    @others_collection = OthersCollection.find(params[:id])
  end

  def others_collections_params
    params.require(:others_collection).permit(:senders_name,:senders_address,:time_line,:union_id,
                                                   collection_money_attributes:[:fee,:fine,:remain,:union_id])
  end


  def file_name
    pdf_file_name 'others_collections_' << @others_collection.union_code
  end

end