class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:username]

  belongs_to :union
  has_many :citizens,  through: :union
  has_many :trade_organizations, through: :union

  def email_required?
    false
  end

  def email_changed?
    false
  end

end
