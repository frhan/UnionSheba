class CollectionMoneysController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  load_and_authorize_resource

  def index

    @start_date = DateTime.parse(params[:start_date]) if params[:start_date].present?
    @end_date = DateTime.parse(params[:end_date]) if params[:end_date].present?

    if @start_date && @end_date
      @collection_moneys = current_user.collection_moneys
                               .where(status: :active, :created_at => @start_date.beginning_of_day..@end_date.end_of_day)
                               .order("created_at desc")
    else
      @collection_moneys = current_user.collection_moneys
                               .where(status: :active)
                               .order("created_at desc")
    end

    #logger.debug(params[:collections][:type])
    if params[:collections].present? && params[:collections][:type].present? && params[:collections][:type] != 'all'
      @collection_moneys = @collection_moneys
                               .where(collectable_type: params[:collections][:type])
    end

    total_fee = @collection_moneys.sum(:fee)
    total_fine = @collection_moneys.sum(:fine)
    total_remain = @collection_moneys.sum(:remain)
    total_vat = @collection_moneys.sum(:vat)
    total = total_fee + total_fine +total_remain + total_vat

    @collection_total = {total_fee: total_fee, total_fine: total_fine, total_remain: total_remain,
                         total_vat: total_vat, total: total}

    # unless @collection_moneys.kind_of?(Array)
    #   @collection_moneys = @collection_moneys.page(params[:page]).per(10)
    # else
    @collection_moneys_kaminary = Kaminari
                                      .paginate_array(@collection_moneys)
                                      .page(params[:page])
                                      .per(20)
    #end

    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => file_name,
               :template => 'collection_moneys/index.pdf.erb',
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               :show_as_html => params[:debug].present?,
               margin: {top: 10, # default 10 (mm)
                        bottom: 0,
                        left: 5,
                        right: 5},
               dpi: '300'
        #zoom: 1.17647
      end
    end
  end

  private

  def file_name
    pdf_file_name 'money_collection_'
  end

end