module UnionHelper

  def union_name_bng
    self.union.name_in_bng
  end

  def union_no
    self.union.union_no.to_s
  end

  def union_code
    self.union.union_code
  end

  def post_name_bng
    self.union.post
  end

  def upazila_name_bng
    self.union.upazila.name_in_bng
  end

  def zila_name_bng
    self.union.upazila.district.name_in_bng
  end

  def signature?
    return true
  end

  def union_logo_name
    self.union.logo_img_name
  end

  def union_bg_name
    self.union.bg_img_name
  end

  def union_sig_name
    self.union.sig_img_name
  end

end