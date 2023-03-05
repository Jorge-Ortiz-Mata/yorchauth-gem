class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true, length: { minimum: 8 }
end
