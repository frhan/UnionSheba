module CollectionBanglaHelper

  def serial_no_bangla
    bangla_number self.collection_money.serial_no.to_s
  end

  def fine_bangla
    fee_number_decimal self.collection_money.fine
  end

  def fee_bangla
    fee_number_decimal self.collection_money.fee
  end

  def total_bangla
    fee_number_decimal self.collection_money.total
  end

  def fee_number_decimal(number)
    taka =  number.present? ? number : 0
    taka = '%.2f' % taka
    bangla_number taka.to_s
  end

end