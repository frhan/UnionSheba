class AddOthersCertificateToFreedomFighter < ActiveRecord::Migration
  def change
    add_reference :freedom_fighters, :others_certificate, index: true, foreign_key: true
  end
end
