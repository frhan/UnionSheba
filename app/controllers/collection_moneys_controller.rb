class CollectionMoneysController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @collection_moneys = current_user.collection_moneys.order("created_at desc")

    # unless @collection_moneys.kind_of?(Array)
    #   @collection_moneys = @collection_moneys.page(params[:page]).per(10)
    # else
      @collection_moneys = Kaminari.paginate_array(@collection_moneys).page(params[:page]).per(10)
    #end

    respond_to do |format|
      format.html
    end
  end

end