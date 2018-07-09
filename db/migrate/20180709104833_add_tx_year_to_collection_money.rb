class AddTxYearToCollectionMoney < ActiveRecord::Migration
  def up
    add_column :collection_moneys, :tx_year, :integer

    CollectionMoney.find_each do |cm|
      year = 2018 if cm.created_at >= '2018-07-01 00:00:00.000000' and  cm.created_at <= '2019-06-30 23:59:00.000000'
      year = 2017 if cm.created_at >= '2017-07-01 00:00:00.000000' and  cm.created_at <= '2018-06-30 23:59:00.000000'
      year = 2016 if cm.created_at >= '2016-07-01 00:00:00.000000' and  cm.created_at <= '2017-06-30 23:59:00.000000'
      year = 2015 if cm.created_at >= '2015-07-01 00:00:00.000000' and  cm.created_at <= '2014-06-30 23:59:00.000000'
      year = 2014 if cm.created_at >= '2014-07-01 00:00:00.000000' and  cm.created_at <= '2013-06-30 23:59:00.000000'
      cm.tx_year = year;
      cm.save!
    end
  end

  def down
    remove_column :collection_moneys, :tx_year
  end
end
