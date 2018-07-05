class TaxOrRateCollectionDatatable
  delegate :params,:link_to,:can?, :tax_or_rate_collection_path, :edit_tax_or_rate_collection_path, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
        data: data,
        recordsTotal:  active_tax_or_rates.count,
        recordsFiltered: sort_order_filter.count
    }
  end
  private

  def active_tax_or_rates
    @filtered_tax_or_rate_collections = @user.tax_or_rate_collections
                                            .where(status: :active)
                                            .order('created_at desc')
  end

  def sort_order_filter
    records = active_tax_or_rates.order("#{sort_column} #{sort_direction}")
    if params[:search][:value].present?
      records = records.where("lower(owners_name_in_english) like :search or lower(owners_name) like :search",
                              search: "%#{params[:search][:value]}%")
    end
    records
  end

  def display_on_page
    Kaminari.paginate_array(sort_order_filter).page(page).per(per_page)
    #sort_order_filter.page(page).per(per_page)
  end

  def data
    tax_or_rates = []
    display_on_page.map do |record|
      tax_or_rate = []
      tax_or_rate <<  link_to(formatted_date_time(record.created_at), tax_or_rate_collection_path(record))
      tax_or_rate <<  link_to(record.owners_name_in_english, tax_or_rate_collection_path(record))
      tax_or_rate <<  link_to(record.owners_name, tax_or_rate_collection_path(record))
      tax_or_rate << record.village_name
      tax_or_rate << record.collection_money.total
      tax_or_rate << edit_link(record)
      tax_or_rate << del_link(record)
      tax_or_rates << tax_or_rate
    end
    tax_or_rates
  end

  def edit_link(record)
    return  link_to("Edit", edit_tax_or_rate_collection_path(record)) if can? :edit, TaxOrRateCollection
    '-'
  end

  def del_link(record)
    return link_to("Delete", tax_or_rate_collection_path(record), method: :delete, data: { confirm: 'Are you sure?' }) if can? :delete, TaxOrRateCollection
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
    columns = %w[created_at owners_name_in_english owners_name village_name not_orderable not_orderable not_orderable ]
    columns[params[:order][:'0'][:column].to_i]
  end

  def sort_direction
    params[:order][:'0'][:dir] == "asc" ? "asc" : "desc"
  end

end