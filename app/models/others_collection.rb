class OthersCollection < ActiveRecord::Base
  has_one :collection_money, as: :collectable
end
