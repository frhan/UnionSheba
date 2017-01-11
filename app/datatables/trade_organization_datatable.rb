class TradeOrganizationDatatable
  delegate :params,:fa_icon, :link_to,:can?, :trade_organization_path, :edit_trade_organization_path, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: total_records,
        iTotalDisplayRecords: trade_organizations.count,
        aaData: data
    }
  end

  private

  def data
    trd_orgs = []
    trade_organizations.map do |record|
      trd_org = []
      trd_org <<  link_to(record.license_no, trade_organization_path(record))
      trd_org <<  link_to(record.enterprize_name_in_eng, trade_organization_path(record))
      trd_org << record.owners_name_eng
      trd_org << record.business_place
      trd_org << link_to("Edit", edit_trade_organization_path(record)) if can? :edit, TradeOrganization
      trd_org << link_to("Delete", trade_organization_path(record), method: :delete, data: { confirm: 'Are you sure?' }) if can? :delete, TradeOrganization

      trd_orgs << trd_org
    end
  trd_orgs
  end

  def trade_organizations
    @trade_organizations ||= fetch_trade_organizations
  end

  def fetch_trade_organizations
    trade_organizations = @user.trade_organizations.order("#{sort_column} #{sort_direction}")
    trade_organizations = trade_organizations.where(status: :active);
    #trade_organizations = trade_organizations.page(page).per(per_page)
    if params[:sSearch].present?
      trade_organizations = trade_organizations.where("license_no like :search or lower(enterprize_name_in_eng) like lower(:search) or lower(owners_name_eng) like lower(:search)",
                                                      search: "%#{params[:sSearch]}%")
    end
    trade_organizations = Kaminari.paginate_array(trade_organizations).page(page).per(per_page)
    trade_organizations
  end

  def total_records
    trade_organizations = @user.trade_organizations
    trade_organizations = trade_organizations.where(status: :active);
    trade_organizations.count
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[license_no enterprize_name_in_eng owners_name_eng not_orderable not_orderable not_orderable]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end


end