class Relationship < ActiveRecord::Base
  belongs_to :others_certificate
  scope :with_lang, -> (lang) { where(lang: lang) }
end
