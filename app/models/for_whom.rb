class ForWhom < ActiveRecord::Base
  has_many :work_info

  def own?
    return self.who == 'own'
  end

  def father?
    return self.who == 'father'
  end

  def mother?
    return self.who == 'mother'
  end

  def husband?
    return self.who == 'husband'
  end

  def other?
    return self.who == 'other'
  end

end
