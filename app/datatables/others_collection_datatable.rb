class OthersCollectionDatatable
  delegate :params,:link_to,:can?, :others_collection_path, :edit_others_collection_path, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
        data: data,
        recordsTotal:  active_others_collections.count,
        recordsFiltered: sort_order_filter.count
    }
  end
  private

  def active_others_collections
    @filtered_others_collections = @user.others_collections.where(status: :active)
  end

  def sort_order_filter
    records = active_others_collections.order("#{sort_column} #{sort_direction}")
    if params[:search][:value].present?
      records = records.where("lower(senders_name) like :search", search: "%#{params[:search][:value]}%")
    end
    records
  end

  def display_on_page
    Kaminari.paginate_array(sort_order_filter).page(page).per(per_page)
    #sort_order_filter.page(page).per(per_page)
  end

  def data
    otherss = []
    display_on_page.map do |record|
      others = []
      others <<  link_to(formatted_date_time(record.created_at), others_collection_path(record))
      others <<  link_to(record.owners_name_in_english, others_collection_path(record))
      others <<  link_to(record.senders_name, others_collection_path(record))
      others << record.senders_address
      others << record.collection_money.total
      others << edit_link(record)
      others << del_link(record)
      otherss << others
    end
    otherss
  end

  def edit_link(record)
    return  link_to("Edit", edit_others_collection_path(record)) if can? :edit, OthersCollection
    ''
  end

  def del_link(record)
    return link_to("Delete", others_collection_path(record), method: :delete, data: { confirm: 'Are you sure?' }) if can? :delete, OthersCollection
    ''
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
    columns = %w[created_at owners_name_in_english senders_name senders_address not_orderable not_orderable not_orderable]
    columns[params[:order][:'0'][:column].to_i]
  end

  def sort_direction
    params[:order][:'0'][:dir] == "desc" ? "desc" : "asc"
  end
end