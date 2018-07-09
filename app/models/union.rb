class Union < ActiveRecord::Base
  belongs_to :upazila
  has_many :citizens
  has_many :trade_organizations
  has_many :collection_moneys
  has_many :tax_or_rate_collections
  has_many :others_collections
  has_many :warishes
  has_many :expenses

  def to_s
    name_in_bng
  end

  def logo_img_name
    logo = ''
    logo << self.union_code.downcase
    logo << '_logo.png'
    logo
  end

  def bg_img_name
    bg = ''
    bg << self.union_code.downcase
    bg << '_bg.png'
  end

  def sig_img_name
    sig = ''
    sig << self.union_code.downcase
    sig << '_sig.jpg'
  end


end
