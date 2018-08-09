class CashBooksController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    @start_date = from_date
    @end_date = to_date

    @collections = current_user.collection_moneys
        .where(status: :active, :created_at => @start_date.beginning_of_day..@end_date.end_of_day)
        .order("voucher_id asc")

    @expenses = current_user.expenses
                    .where(status: :active, :created_at => @start_date.beginning_of_day..@end_date.end_of_day)
                    .order("voucher_id asc")

  end

end
