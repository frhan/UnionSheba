module HomeHelper
  def nid_or_birthid_path(citizen)
    return show_by_birthid_citizen_request_path(citizen.birthid) if citizen.birthid.present?
    return show_by_nid_citizen_request_path(citizen.nid) if citizen.nid.present?
  end
end
