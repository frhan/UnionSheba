class RemoveWorkInfoFromOthersCertificate < ActiveRecord::Migration
  def change
    remove_reference :others_certificates, :work_info, index: true
    remove_column :others_certificates, :lang
  end
end
