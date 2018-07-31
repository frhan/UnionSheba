class AddOthersCertificateToRelationships < ActiveRecord::Migration
  def change
    add_reference :relationships, :others_certificate, index: true, foreign_key: true
  end
end
