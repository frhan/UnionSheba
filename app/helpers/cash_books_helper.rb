module CashBooksHelper
  def TYPES
    {'প্রাপ্তি' => :in, 'প্রদান' => :out}
  end

  def minus_val val
    return '('<<val.to_s<<')'.to_s if val < 0
    val.to_s
  end
end
