class Citizen < ActiveRecord::Base
  belongs_to :union

  #TODO: before save nid and birthid should be saved in english
end
