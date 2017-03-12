module TaxOrRateCollectionHelper

  def show_apprisal?(tax_or_rate_collection)
    return false if tax_or_rate_collection.nil?
    return true if tax_or_rate_collection.apprisal_no.present?
    return false
  end
end