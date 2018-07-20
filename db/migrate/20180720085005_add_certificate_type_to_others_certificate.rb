class AddCertificateTypeToOthersCertificate < ActiveRecord::Migration
  def change
    add_column :others_certificates, :certificate_type, :string
  end
end
