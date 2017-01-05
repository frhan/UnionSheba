module CollectionBanglaHelper

  def serial_no_bangla
    bangla_number self.collection_money.serial_no.to_s
  end

  def fine_bangla
    bangla_number self.collection_money.fine.to_s
  end

  def fee_bangla
    bangla_number self.collection_money.fee.to_s
  end

  def total_bangla
    bangla_number self.collection_money.total.to_s
  end

end