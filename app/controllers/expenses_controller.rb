class ExpensesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: ExpenseDatatable.new(view_context, current_user) }
    end

  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end

  end

  def update

    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Collection  was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @expense.update_attributes(status: :deleted)

    respond_to do |format|
      format.html { redirect_to expenses_path, notice: 'Collection was successfully destroyed.' }
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
               margin: {top: 10, # default 10 (mm)
                        bottom: 0,
                        left: 12,
                        right: 12},
               dpi: '300'
        #zoom: 1.17647
      end
    end

  end


  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
      params.require(:expense).permit(:expense_money, :note,
                                      :other_category,:union_id,
                                      :expense_category_id)
  end
end

