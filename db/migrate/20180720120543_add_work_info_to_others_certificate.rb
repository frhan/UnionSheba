class AddWorkInfoToOthersCertificate < ActiveRecord::Migration
  def change
    add_reference :others_certificates, :work_info, index: true, foreign_key: true
  end
end
