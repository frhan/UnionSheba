class CollectionMoney < ActiveRecord::Base
  belongs_to :collectable,polymorphic: true
  validates :fee,presence: true
  belongs_to :union

  after_create :save_serial_no

  def total
    total = 0.0
    total = total + self.fee if self.fee.present?
    total = total + self.remain if self.remain.present?
    total = total + self.fine if self.fine.present?
    total = total + self.vat if self.vat.present?
    total
  end

  def trade_license?
    self.collectable_type == :TradeLicense
  end

  def tax_or_rate?
    self.collectable_type == :TaxOrRateCollection
  end

  def others?
    self.collectable_type == :OthersCollection
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

  def self.Types
    { 'সব'=> :all, 'ট্যাক্স ও রেট'=> :TaxOrRateCollection,'বিবিধ'=> :OthersCollection,
     'ট্রেড লাইসেন্স'=> :TradeLicense }
  end

  def money_senders_name
    self.collectable.money_senders_name if collectable.present?
  end

 private

  def save_serial_no
    serial_no = CollectionMoney.where(union_id: self.union.id,collectable_type: self.collectable_type).count
    self.update_attributes(:serial_no => serial_no)
  end

end
