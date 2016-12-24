class User < ActiveRecord::Base
  include UnionHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:username]

  belongs_to :union
  belongs_to :role
  has_many :citizens,  through: :union
  has_many :trade_organizations, through: :union

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def admin?
    self.role.role_name == 'admin'
  end

  def user?
    self.role.role_name == 'user'
  end

  def role_name
    self.role.role_name
  end

  def has_role?(role_name)
    self.role.role_name == role_name
  end

end
