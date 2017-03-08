module TradeOrganizationHelper
  def current_fiscal_year
    now = Time.now
    year = now.year
    year = now.year - 1 if now.month < 6 #if fiscal year less than june
    year.to_s
  end
end
