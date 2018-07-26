class Citizen < ActiveRecord::Base
  include ApplicationHelper, UnionHelper,Certificatable

  after_create :save_tracking_id
  after_save :save_certificate_no

  def save_pending_request
    set_status(:pending)
    save_requested_at
  end

  def update_pending_request_to_active
    set_status :active
    save_saved_at
  end

  def save_requested_at
    self.requested_at = Time.now
  end

  def save_saved_at
    self.saved_at = Time.now
  end

  def requested_at_formatted
    return String.new unless requested_at.present?
    self.requested_at.strftime("%d-%m-%Y %I:%M:%S %p")
  end

  def self.GENDERS
    {'পুরুষ' => :male, 'মহিলা' => :female, 'অন্যান্য' => :others}
  end

  def self.STATUS
    [:active, :pending]
  end

  def male?
    self.gender == 'male'
  end

  def female?
    self.gender == 'female'
  end

  def others?
    self.gender == 'others'
  end

  def gender_bangla
    return String.new unless self.gender.present?
    return 'পুরুষ' if male?
    return 'মহিলা' if female?
    return 'অন্যান্য' if others?
  end

  def barcode
    barcode = ''
    if self.basic_information.present?
      barcode << self.basic_information.name if self.basic_information.name.present?
      barcode << "\n"
    end

    if self.citizen_basic.present?
      if self.citizen_basic.nid.present?
        barcode << 'NID#'<< self.citizen_basic.nid << "\n"
      elsif self.citizen_basic.birthid.present?
        barcode << 'BirthId# '<< self.citizen_basic.nid .birthid << "\n"
      end
    end

    barcode << 'Union: ' << self.union.name_in_bng
    barcode
  end

  def citizen_no_pdf
    return bangla_number(self.citizen_no) if self.citizen_no.present?
    bangla_number '1234567'
  end

  def save_certificate_no
    return if self.pending? || self.citizen_no.present?

    ctzn_no = Citizen.where(union_id: self.union.id).count(:citizen_no)
    ctzn_no = ctzn_no + 1
    ctzn = "#{self.union.union_code}C#{current_year.to_s}#{ctzn_no.to_s}"
    self.update_attributes(:citizen_no => ctzn)
  end


  def save_tracking_id
    return if self.active? || self.tracking_id.present?

    trac_no = Citizen.where(union_id: self.union.id).count(:tracking_id)
    trac_id = "#{self.union.union_code}C#{current_year_month_day.to_s}#{trac_no.to_s}"
    self.update_attributes(:tracking_id => trac_id)
  end


end
