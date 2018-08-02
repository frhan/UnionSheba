class OthersCertificate < ActiveRecord::Base
  include ApplicationHelper, UnionHelper, Certificatable

  after_create :save_tracking_id, :save_certificate_no
  has_many :work_infos, dependent: :destroy
  #has_many :freedom_fighters

  accepts_nested_attributes_for :work_infos, allow_destroy: true

  def save_certificate_no
    return if self.pending? || self.certifcate_no.present?

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

  def template
    return 'others_certificates/pdf/no_remarried.pdf.erb' if self.certificate_type == 'no_remarried'
    return 'others_certificates/pdf/unmarried.pdf.erb' if self.certificate_type == 'unmarried'
    return 'others_certificates/pdf/married.pdf.erb' if self.certificate_type == 'married'
    return 'others_certificates/pdf/unemployed.pdf.erb' if self.certificate_type == 'unemployed'
    return 'others_certificates/pdf/landless.pdf.erb' if self.certificate_type == 'landless'
    return 'others_certificates/pdf/non_solvent.pdf.erb' if self.certificate_type == 'non_solvent'
    return 'others_certificates/pdf/orphan.pdf.erb' if self.certificate_type == 'orphan'
    return 'others_certificates/pdf/freedom_fighter.pdf.erb' if self.certificate_type == 'freedom_fighter'
    return 'others_certificates/pdf/income_yearly.pdf.erb' if self.certificate_type == 'income_yearly'
    return 'others_certificates/pdf/income_monthly.pdf.erb' if self.certificate_type == 'income_monthly'
  end

end