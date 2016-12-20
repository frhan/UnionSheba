class Citizen < ActiveRecord::Base
  belongs_to :union

  #TODO: before save nid and birthid should be saved in english
  validates :name_in_eng,:name_in_bng ,:fathers_name,:mothers_name,
            :village,:post,:word_no, presence: true
end
