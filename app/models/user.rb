class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:phone]

  enum role: [:user, :doctor, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if conditions.has_key?(:phone)
      where(conditions.to_h).first
    end
  end

end
