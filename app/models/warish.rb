class Warish < ActiveRecord::Base
  include ApplicationHelper, UnionHelper,Certificatable
  has_many :warish_relations, dependent: :destroy

  accepts_nested_attributes_for :warish_relations, reject_if: :all_blank, allow_destroy: true

  after_create :save_tracking_id
  after_save :save_certificate_no

  def save_certificate_no
    return if self.pending? || self.warish_no.present?

    warsh_no = Warish.where(union_id: self.union.id).count(:warish_no)
    warsh_no = warsh_no + 1
    warsh = "#{self.union.union_code}W#{current_year.to_s}#{warsh_no.to_s}"
    self.update_attributes(:warish_no => warsh)
  end


  def save_tracking_id
    return if self.active? || self.tracking_id.present?

    trac_no = Warish.where(union_id: self.union.id).count(:tracking_id)
    trac_id = "#{self.union.union_code}W#{current_year_month_day.to_s}#{trac_no.to_s}"
    self.update_attributes(:tracking_id => trac_id)
  end


end
