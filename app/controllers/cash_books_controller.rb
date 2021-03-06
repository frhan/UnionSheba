class CashBooksController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    @start_date = from_date
    #@end_date = to_date

    @books_type = 'in'
    @books_type = params[:books][:type] if params[:books].present? && params[:books][:type].present?

    @collections = current_user.collection_moneys
                       .where(status: :active,
                              created_at: @start_date.beginning_of_day..@start_date.end_of_day)
                       .order("voucher_id,id desc")

    if(!(@start_date.month == 7 && @start_date.day == 1))
      @initial_collections = current_user.collection_moneys
                               .where(status: :active,
                                      created_at: fday_fiscal_year(@start_date)
                                                      .beginning_of_day..@start_date
                                                      .yesterday.end_of_day)
    end

    @expenses = current_user.expenses
                    .where(status: :active,
                           created_at: @start_date.beginning_of_day..@start_date.end_of_day)
                    .order("id asc")
    if(!(@start_date.month == 7 && @start_date.day == 1))
      @inital_expenses = current_user.expenses.where(status: :active,
                                                      created_at: fday_fiscal_year(@start_date)
                                                                      .beginning_of_day..@start_date.yesterday.end_of_day)
                                                                      .sum(:expense_money)
    end

    if !@initial_collections.blank?
      total_fee = @initial_collections.sum(:fee)
      total_fine = @initial_collections.sum(:fine)
      total_remain = @initial_collections.sum(:remain)
      @initial_collections = total_fee + total_fine + total_remain
    end

    @initial_collections = 0 if @initial_collections.blank?
    @inital_expenses = 0 if @inital_expenses.blank?

    #todays_total_collection = @collections.sum(:fee) + @collections.sum(:fine) + @collections.sum(:remain)

    last_year_balance = 0
    last_year_balances = current_user.balance_moneys.where(tax_year: cfiscal_year(@start_date) - 1)
    last_year_balance = last_year_balances.first.value if last_year_balances.present?

    @balance = @initial_collections - @inital_expenses + last_year_balance

    #@todays_balance = @balance + todays_total_collection

    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => file_name,
               :template => template_name(@books_type),
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               page_size: 'A4',
               :show_as_html => params[:debug].present?,
               margin: {top: 8, # default 10 (mm)
                        bottom: 0,
                        left: 5,
                        right: 5},
               dpi: '300'
      end
    end
  end

  private

  def template_name books_type
    return 'cash_books/in.pdf.erb' if books_type == 'in'
    return 'cash_books/out.pdf.erb' if books_type == 'out'
  end

  def file_name
    pdf_file_name 'cash_book_' << current_user.union_code
  end

end
