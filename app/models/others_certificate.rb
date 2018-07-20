class OthersCertificate < ActiveRecord::Base
  include ApplicationHelper, UnionHelper,Certificatable

  after_create :save_tracking_id,:save_certificate_no

  private

  def save_certificate_no
    return if self.pending? || self.citizen_no.present?

    cer_no = OthersCertificate.where(union_id: self.union.id).count(:certifcate_no)
    cer_no = cer_no + 1
    cer = "#{self.union.union_code}S#{current_year.to_s}#{cer_no.to_s}"
    self.update_attributes(:certifcate_no => cer)
  end


  def save_tracking_id
    return if self.active? || self.tracking_no.present?

    trac_no = OthersCertificate.where(union_id: self.union.id).count(:tracking_no)
    trac_id = "#{self.union.union_code}S#{current_year_month_day.to_s}#{trac_no.to_s}"
    self.update_attributes(:tracking_no => trac_id)
  end

end