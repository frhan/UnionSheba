class ExpenseDatatable
  delegate :params,:link_to,:can?, :expense_path, :edit_expense_path, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
        data: data,
        recordsTotal:  active_expenses.count,
        recordsFiltered: sort_order_filter.count
    }
  end
  private

  def active_expenses
    @filtered_expense = @user.expenses.where(status: :active)
                                      .order('created_at desc')
  end

  def sort_order_filter
    records = active_expenses.order("#{sort_column} #{sort_direction}")
    # if params[:search][:value].present?
    #   records = records.where("lower(owners_name_in_english) like :search or lower(owners_name) like :search",
    #                           search: "%#{params[:search][:value]}%")
    # end
    records
  end

  def display_on_page
    Kaminari.paginate_array(sort_order_filter).page(page).per(per_page)
    #sort_order_filter.page(page).per(per_page)
  end

  def data
    expenses = []
    display_on_page.map do |record|
      expense = []
      expense <<  link_to(formatted_date_time(record.created_at), expense_path(record))
      expense <<  record.expense_money
      expense << record.exp_category
      expense << record.note
      expense << edit_link(record)
      expense << del_link(record)
      expenses << expense
    end
    expenses
  end

  def edit_link(record)
    return  link_to("Edit", edit_expense_path(record)) if can? :edit, Expense
    '-'
  end

  def del_link(record)
    return link_to("Delete", expense_path(record), method: :delete, data: { confirm: 'Are you sure?' }) if can? :delete, Expense
    '-'
  end

  def formatted_date_time(date_time)
    date_time.strftime('%d-%m-%Y') if date_time.present?
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[created_at expense_money  not_orderable not_orderable not_orderable not_orderable ]
    columns[params[:order][:'0'][:column].to_i]
  end

  def sort_direction
    params[:order][:'0'][:dir] == "asc" ? "asc" : "desc"
  end

end