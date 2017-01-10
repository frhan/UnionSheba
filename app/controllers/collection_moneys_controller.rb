class CollectionMoneysController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index

    start_date = DateTime.parse(params[:start_date]) if params[:start_date].present?;
    end_date = DateTime.parse(params[:end_date]) if params[:end_date].present?;

    if start_date && end_date
      @collection_moneys = current_user.collection_moneys.
          where(:created_at =>start_date.beginning_of_day..end_date.end_of_day).
          order("created_at desc")
    else
      @collection_moneys = current_user.collection_moneys.order("created_at desc")
    end

    # unless @collection_moneys.kind_of?(Array)
    #   @collection_moneys = @collection_moneys.page(params[:page]).per(10)
    # else
      @collection_moneys = Kaminari.paginate_array(@collection_moneys).page(params[:page]).per(10)
    #end

    respond_to do |format|
      format.html
      format.js
    end
  end

end