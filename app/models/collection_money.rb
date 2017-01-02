class CollectionMoney < ActiveRecord::Base
  belongs_to :collectable,polymorphic: true
  validates :fee,presence: true
end
