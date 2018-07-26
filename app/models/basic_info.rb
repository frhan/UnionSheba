class BasicInfo < ActiveRecord::Base
  belongs_to :infoable, polymorphic: true

  validates :name,:fathers_name,:mothers_name , presence: true
  validates :father_alive, inclusion: { in: [ true, false ] }

  scope :en, -> { where(lang: :en) }

  scope :bn, -> { where(lang: :bn) }

  scope :info, -> (lang) { where(lang: lang) }

  def fathers_name_live
    return self.fathers_name if father_alive
    return "'মরহুম' #{self.fathers_name}" if self.lang == 'bn'
    return "'Late' #{self.fathers_name}" if self.lang == 'en'
  end

  def mother_name_live
    return self.mothers_name if mother_alive
    return "'মরহুমা '#{self.mothers_name}" if self.lang == 'bn'
    return "'Late '#{self.mothers_name}" if self.lang == 'en'
  end

end
