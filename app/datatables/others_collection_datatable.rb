class OthersCollectionDatatable
  delegate :params,:link_to,:can?, :others_collection_path, :edit_others_collection_path, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: total_records,
        iTotalDisplayRecords: others_collections.count,
        aaData: data
    }
  end
  private

  def data
    otherss = []
    others_collections.map do |record|
      others = []
      others <<  link_to(formatted_date_time(record.created_at), others_collection_path(record))
      others <<  link_to(record.owners_name_in_english, others_collection_path(record))
      others <<  link_to(record.senders_name, others_collection_path(record))
      others << record.senders_address
      others << record.collection_money.total
      others << link_to("Edit", edit_others_collection_path(record)) if can? :edit, OthersCollection
      others << link_to("Delete", others_collection_path(record), method: :delete, data: { confirm: 'Are you sure?' }) if can? :delete, OthersCollection

      otherss << others
    end
    otherss
  end

  def formatted_date_time(date_time)
    date_time.strftime('%d-%m-%Y') if date_time.present?
  end

  def others_collections
    @others_collections ||= fetch_others_collections
  end

  def fetch_others_collections
    others_collections = @user.others_collections.order("#{sort_column} #{sort_direction}")
    others_collections = others_collections.where(status: :active);
    if params[:sSearch].present?
      others_collections = others_collections.where("lower(senders_name) like :search", search: "%#{params[:sSearch]}%")
    end
    others_collections = Kaminari.paginate_array(others_collections).page(page).per(per_page)
    others_collections
  end

  def total_records
    others_collections = @user.others_collections.where(status: :active);
    others_collections.count
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[created_at owners_name_in_english senders_name senders_address not_orderable not_orderable not_orderable]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end