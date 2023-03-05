class User < ApplicationRecord
  has_secure_password
  has_secure_token :token_id, length: 50

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true, length: { minimum: 8 }
end
