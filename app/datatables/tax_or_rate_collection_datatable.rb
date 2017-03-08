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
    @filtered_tax_or_rate_collections = @user.tax_or_rate_collections.where(status: :active)
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
      tax_or_rate << link_to("Edit", edit_tax_or_rate_collection_path(record)) if can? :edit, TaxOrRateCollection
      tax_or_rate << link_to("Delete", tax_or_rate_collection_path(record), method: :delete, data: { confirm: 'Are you sure?' }) if can? :delete, TaxOrRateCollection

      tax_or_rates << tax_or_rate
    end
    tax_or_rates
  end

  def formatted_date_time(date_time)
    date_time.strftime('%d-%m-%Y') if date_time.present?
  end

  # def tax_or_rate_collections
  #   @tax_or_rate_collections ||= fetch_tax_or_rate_collections
  # end

  # def fetch_tax_or_rate_collections
  #   tax_or_rate_collections = @user.tax_or_rate_collections.order("#{sort_column} #{sort_direction}")
  #   tax_or_rate_collections = tax_or_rate_collections.where(status: :active);
  #   if params[:sSearch].present?
  #     tax_or_rate_collections = tax_or_rate_collections.where("lower(owners_name_in_english) like :search or lower(owners_name) like :search", search: "%#{params[:sSearch]}%")
  #   end
  #   tax_or_rate_collections = Kaminari.paginate_array(tax_or_rate_collections).page(page).per(per_page)
  #   tax_or_rate_collections
  # end

  # def total_records
  #   tax_or_rate_collections = @user.tax_or_rate_collections.where(status: :active);
  #   tax_or_rate_collections.count
  # end

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
    params[:order][:'0'][:dir] == "desc" ? "desc" : "asc"
  end

end