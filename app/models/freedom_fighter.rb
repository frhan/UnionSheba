class FreedomFighter < ActiveRecord::Base
  belongs_to :others_certificate
  #belongs_to :union, through: :others_certificate
  scope :with_lang, -> (lang) { where(lang: lang) }

end
