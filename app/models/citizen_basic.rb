class CitizenBasic < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :basicable, polymorphic: true

  belongs_to :maritial_status
  belongs_to :citizenship_state
  belongs_to :religion

  validate :nid_or_birthid_present
  validate :nid_birthid_numeric

  #validates_uniqueness_of :nid, :allow_blank => true, :allow_nil => true, scope: [:basicable_type]
  #validates_uniqueness_of :birthid, :allow_blank => true, :allow_nil => true, scope: [:basicable_type]
  validates :nid, length: {minimum: 13}, :allow_blank => true, :allow_nil => true
  validates :birthid, length: {minimum: 17}, :allow_blank => true, :allow_nil => true

  def nid_or_birthid
    return self.nid if nid.present?
    return self.birthid if birthid.present?
  end

  private

  def nid_or_birthid_present
    errors.add(:citizen, " National Id or BirthId is required") unless nid.present? || birthid.present?
  end

  def nid_birthid_numeric
    errors.add(:citizen, " National Id/BirthId is not a number") unless nid_or_birthid_numeric?
  end

  def save_nid_birthdid_as_english
    self.nid = english_number(nid) if nid.present?
    self.birthid = english_number(birthid) if birthid.present?
  end

  def nid_or_birthid_numeric?
    isnumber = is_numeric(nid.to_s) if nid.present?
    isnumber = is_numeric(birthid.to_s) if birthid.present?
    isnumber
  end

end
