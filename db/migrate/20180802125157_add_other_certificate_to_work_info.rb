class AddOtherCertificateToWorkInfo < ActiveRecord::Migration
  def change
    add_reference :work_infos, :others_certificate, index: true, foreign_key: true
  end
end
