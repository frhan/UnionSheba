class MaritialStatus < ActiveRecord::Base
  has_many :citizen_basics

  def married?
    return self.name_en.downcase == 'married'
  end

  def unmarried?
    return self.name_en.downcase == 'unmarried?'
  end

  def widow?
    return self.name_en.downcase == 'widow'
  end

  def divorced?
    return self.name_en.downcase == 'divorced'
  end

  def others?
    return self.name_en.downcase == 'others'
  end

end
