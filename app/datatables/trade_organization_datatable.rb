class TradeOrganizationDatatable
  delegate :params,:fa_icon, :link_to,:can?, :trade_organization_path, :edit_trade_organization_path, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
        data: data,
        recordsTotal:  my_search.count,
        recordsFiltered: sort_order_filter.count
    }
  end

  private

  def my_search
    @filtered_trade_organizations = @user.trade_organizations
                                        .where(status: :active)
                                        .order('created_at desc')
  end

  def sort_order_filter
    records = my_search.order("#{sort_column} #{sort_direction}")
    if params[:search][:value].present?
      records = records.where("license_no like :search or lower(enterprize_name_in_eng) like lower(:search) or lower(owners_name_eng) like lower(:search)",
                              search: "%#{params[:search][:value]}%")
    end
    records
  end

  def display_on_page
    Kaminari.paginate_array(sort_order_filter).page(page).per(per_page)
    #sort_order_filter.page(page).per(per_page)
  end


  def data
    trd_orgs = []
    display_on_page.map do |record|
      trd_org = []
      trd_org <<  link_to(record.license_no, trade_organization_path(record))
      trd_org <<  link_to(record.enterprize_name_in_eng, trade_organization_path(record))
      trd_org << record.owners_name_eng
      trd_org << record.business_place
      trd_org << edit_link(record)
      trd_org <<  del_link(record)
      trd_orgs << trd_org
    end
  trd_orgs
  end

  def edit_link(record)
   return  link_to("Edit", edit_trade_organization_path(record)) if can? :edit, TradeOrganization
   '-'
  end

  def del_link(record)
    return link_to("Delete", trade_organization_path(record), method: :delete, data: { confirm: 'Are you sure?' }) if can? :delete, TradeOrganization
    '-'
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[license_no enterprize_name_in_eng owners_name_eng not_orderable not_orderable not_orderable]
    columns[params[:order][:'0'][:column].to_i]
  end

  def sort_direction
    params[:order][:'0'][:dir] == "asc" ? "asc" : "desc"
  end


end