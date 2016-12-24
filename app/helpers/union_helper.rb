module UnionHelper

  def union_name_bng
    self.union.name_in_bng
  end

  def union_no
    self.union.union_no.to_s
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

end