class CollectionMoney < ActiveRecord::Base
  belongs_to :collectable,polymorphic: true
end
