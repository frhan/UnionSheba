class TradeOrganizationDatatables
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Product.count,
        iTotalDisplayRecords: products.total_entries,
        aaData: data
    }
  end

  private

  def data
    trade_organizations.map do |trd_org|

    end

  end

  def trade_organizations
    @trade_organizations ||= fetch_trade_organizations
  end

  def fetch_trade_organizations

  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name category released_on price]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end


end