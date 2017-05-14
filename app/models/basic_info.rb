class BasicInfo < ActiveRecord::Base
  belongs_to :infoable, polymorphic: true

  validates :name,:fathers_name,:mothers_name , presence: true

  scope :en, -> { where(lang: :en) }

  scope :bn, -> { where(lang: :bn) }

  scope :info, -> (lang) { where(lang: lang) }

end
