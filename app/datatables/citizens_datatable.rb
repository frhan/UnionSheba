class CitizensDatatable
  delegate :params,:link_to, :citizen_path, :edit_citizen_path, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: total_records,
        iTotalDisplayRecords: citizens.count,
        aaData: data
    }
  end

  private

  def data
    ctzns = []
    citizens.map do |record|
      ctzn = []
      ctzn <<  link_to(record.nid, citizen_path(record))
      ctzn << link_to(record.birthid, citizen_path(record))
      ctzn << record.name_in_eng
      ctzn << record.fathers_name
      ctzn << link_to("Edit", edit_citizen_path(record))
      ctzn << link_to("Delete", citizen_path(record), method: :delete, data: { confirm: 'Are you sure?' })

      ctzns << ctzn
    end
    ctzns
  end

  def citizens
    @citizens ||= fetch_citizens
  end

  def fetch_citizens
    citizens = @user.citizens.order("#{sort_column} #{sort_direction}")
    #trade_organizations = trade_organizations.page(page).per(per_page)
    if params[:sSearch].present?
      citizens = citizens.where("nid like :search or birthid like :search or citizens.name_in_eng like :search", search: "%#{params[:sSearch]}%")
    end
    citizens = Kaminari.paginate_array(citizens).page(page).per(per_page)

    citizens
  end

  def total_records
    citizens = @user.citizens
    citizens.count
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[nid birthid name_in_eng fathers_name edit delete]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end