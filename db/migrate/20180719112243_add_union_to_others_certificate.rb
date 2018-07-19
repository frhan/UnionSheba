class AddUnionToOthersCertificate < ActiveRecord::Migration
  def change
    add_reference :others_certificates, :union, index: true, foreign_key: true
  end
end
