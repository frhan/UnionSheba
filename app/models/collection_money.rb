class CollectionMoney < ActiveRecord::Base
  include ApplicationHelper, VoucherHelper
  belongs_to :collectable, polymorphic: true
  validates :fee, presence: true
  belongs_to :union
  belongs_to :voucher

  after_create :save_serial_no, :save_tax_year, :save_voucher_no

  scope :by_type, lambda { |type, status| joins("INNER JOIN #{type.table_name} ON #{type.table_name}.id = #{CollectionMoney.table_name}.opinionable_id
                                          AND #{Opinion.table_name}.opinionable_type = '#{type.to_s}'") }

  def total
    total = 0.0
    total = total + self.fee if self.fee.present?
    total = total + self.remain if self.remain.present?
    total = total + self.fine if self.fine.present?
    total = total + self.vat if self.vat.present?
    total
  end

  def trade_license?
    self.collectable_type == 'TradeLicense'
  end

  def tax_or_rate?
    self.collectable_type == 'TaxOrRateCollection'
  end

  def others?
    self.collectable_type == 'OthersCollection'
  end

  def trade_license_or_others?
    self.collectable_type == :OthersCollection || self.collectable_type == :TradeLicense
  end

  def collection_reason
    return 'বিবিধ' if collectable_type == 'OthersCollection'
    return 'ট্যাক্স ও রেট' if collectable_type == 'TaxOrRateCollection'
    return 'ট্রেড লাইসেন্স' if collectable_type == 'TradeLicense'
    return String.new
  end

  def babod
    return 'বিবিধ' if collectable_type == 'OthersCollection'
    return self.collectable.babod if collectable_type == 'TaxOrRateCollection'
    return 'ট্রেড লাইসেন্স' if collectable_type == 'TradeLicense'
    return String.new
  end

  def self.Types
    {'সব' => :all, 'ট্যাক্স ও রেট' => :TaxOrRateCollection, 'বিবিধ' => :OthersCollection,
     'ট্রেড লাইসেন্স' => :TradeLicense}
  end

  def money_senders_name
    self.collectable.money_senders_name if collectable.present?
  end

  def remove
    self.update_attributes(status: :deleted)
  end

  def active?
    self.status == 'active'
  end

  def collection_fee
    return self.fee if self.fee.present?
    0.0
  end

  def collection_fine
    return self.fine if self.fine.present?
    0.0
  end

  def collection_remain
    return self.remain if self.remain.present?
    0.0
  end

  def collection_vat
    return self.vat if self.vat.present?
    0.0
  end

  def v_type
    return self.collectable.category if self.tax_or_rate?
    return self.collectable_type
  end

  def main_type
    :collection
  end

  private

  def save_serial_no
    serial_no = CollectionMoney.where(union_id: self.union.id,
                                      collectable_type: self.collectable_type,
                                      tx_year: current_fiscal_year).count
    serial_no = serial_no + 1
    self.update_attributes(:serial_no => serial_no)
  end

  def save_tax_year
    self.update_attributes(:tx_year => current_fiscal_year)
  end

end
