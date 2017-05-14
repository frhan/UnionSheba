class Citizen < ActiveRecord::Base
  include ApplicationHelper, UnionHelper
  belongs_to :union

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :basic_infos, as: :infoable, dependent: :destroy
  has_one :contact_address, as: :contactable, dependent: :destroy
  has_one :citizen_basic, as: :basicable, dependent: :destroy
  has_one :image_attachment, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :basic_infos, allow_destroy: true
  accepts_nested_attributes_for :contact_address, allow_destroy: true
  accepts_nested_attributes_for :citizen_basic, allow_destroy: true
  accepts_nested_attributes_for :image_attachment, allow_destroy: true

  after_create :save_tracking_id
  after_save :save_citizen_no

  def set_status(status)
    self.status = status
  end

  def active?
    self.status == 'active'
  end

  def pending?
    self.status == 'pending'
  end

  def save_pending_request
    set_status(:pending)
    save_requested_at
  end

  def update_pending_request_to_active
    set_status :active
    save_saved_at
  end

  def activate
    self.update_attributes(status: :active)
    save_citizen_no
    delete_image
  end

  def delete_image
    return unless self.image_attachment.present? && self.image_attachment.photo.present?
    self.image_attachment.photo.file.delete if self.image_attachment.photo.file.exists?
    self.image_attachment.delete
  end

  def save_requested_at
    self.requested_at = Time.now
  end

  def save_saved_at
    self.saved_at = Time.now
  end

  def save_citizen_no
    return if self.pending? || self.citizen_no.present?

    ctzn_no = Citizen.where(union_id: self.union.id).count(:citizen_no)
    ctzn_no = ctzn_no + 1
    ctzn = self.union.union_code << 'C' << current_year.to_s << ctzn_no.to_s
    self.update_attributes(:citizen_no => ctzn)
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

  def basic_information
    @basic_info ||= self.basic_infos.info(current_lang).first if self.basic_infos.info(current_lang).present?
    @basic_info
  end

  def present_address
    @present_address ||= self.addresses.present(current_lang).first if self.addresses.present(current_lang).first.present?
    @present_address
  end

  def permanent_address
    @permanent_address ||= self.addresses.permanent(current_lang).first if self.addresses.permanent(current_lang).first.present?
    @permanent_address
  end

  def save_tracking_id
    trac_no = Citizen.where(union_id: self.union.id).count(:tracking_id)
    trac_id = self.union.union_code << '-'<< current_year_month_day.to_s << '-' << trac_no.to_s
    self.update_attributes(:tracking_id => trac_id)
  end

  private


end
