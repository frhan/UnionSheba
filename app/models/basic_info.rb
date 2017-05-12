class BasicInfo < ActiveRecord::Base
  belongs_to :infoable, polymorphic: true

  scope :en, -> { where(lang: :en) }

  scope :en, -> { where(lang: :bn) }

end
