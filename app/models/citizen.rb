class Citizen < ActiveRecord::Base
  belongs_to :union

  def nid_bangla
    self.nid.each_char do |c|

    end
  end

  def birthid_bangla
    '133455'
  end
end
