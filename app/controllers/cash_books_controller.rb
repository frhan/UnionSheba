class CashBooksController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    @start_date = from_date
    @end_date = to_date


  end

end
