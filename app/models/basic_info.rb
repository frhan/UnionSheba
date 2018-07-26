class BasicInfo < ActiveRecord::Base
  belongs_to :infoable, polymorphic: true

  validates :name,:fathers_name,:mothers_name , presence: true
  validates :father_alive, inclusion: { in: [ true, false ] }

  scope :en, -> { where(lang: :en) }

  scope :bn, -> { where(lang: :bn) }

  scope :info, -> (lang) { where(lang: lang) }

end
