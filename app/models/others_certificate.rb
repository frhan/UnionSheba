class OthersCertificate < ActiveRecord::Base
  include ApplicationHelper, UnionHelper, Certificatable

  after_create :save_tracking_id, :save_certificate_no
  has_many :work_infos, dependent: :destroy
  has_many :freedom_fighters, dependent: :destroy
  has_many :relationships, dependent: :destroy

  accepts_nested_attributes_for :work_infos, allow_destroy: true
  accepts_nested_attributes_for :freedom_fighters, allow_destroy: true
  accepts_nested_attributes_for :relationships, allow_destroy: true

  def save_certificate_no
    return if self.pending? || self.certifcate_no.present?

    cer_no = OthersCertificate.where(union_id: self.union.id).count(:certifcate_no)
    cer_no = cer_no + 1
    #cer = "#{self.union.union_code}S#{current_year.to_s}#{cer_no.to_s}"
    cer = get_unique_certificate_no cer_no
    self.update_attributes(:certifcate_no => cer)
  end

  def save_tracking_id
    return if self.active? || self.tracking_no.present?

    trac_no = OthersCertificate.where(union_id: self.union.id).count(:tracking_no)
    trac_id = "#{self.union.union_code}S#{current_year_month_day.to_s}#{trac_no.to_s}"
    self.update_attributes(:tracking_no => trac_id)
  end

  def work_info
    @work_info ||= self.work_infos.info(current_lang).first
    @work_info
  end

  def freedom_fighter
    @freedom_fighter ||= self.freedom_fighters.with_lang(current_lang).first
    @freedom_fighter
  end


  def relationship
    @relationship ||= self.relationships.with_lang(current_lang).first
    @relationship
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
    return 'others_certificates/pdf/income.pdf.erb' if should_show_work_info? self.certificate_type
    return 'others_certificates/pdf/only_widow.pdf.erb' if self.certificate_type == 'only_widow'
    return 'others_certificates/pdf/permanent_citizen.pdf.erb' if self.certificate_type == 'permanent_citizen'
    return 'others_certificates/pdf/same_name.pdf.erb' if self.certificate_type == 'same_name'
    return 'others_certificates/pdf/relationship.pdf.erb' if self.certificate_type == 'relationship'
    return 'others_certificates/pdf/orphan.pdf.erb' if self.certificate_type == 'orphan'
    return 'others_certificates/pdf/address_change.pdf.erb' if self.certificate_type == 'address_change'
  end

  private

  def get_unique_certificate_no(sl_no)
    cer_no = "#{self.union.union_code}S#{current_year.to_s}#{sl_no.to_s}"
    certificate = OthersCertificate.find_by_certifcate_no(cer_no)
    return cer_no if certificate.blank?
    return get_unique_certificate_no(sl_no + 1)
  end

end