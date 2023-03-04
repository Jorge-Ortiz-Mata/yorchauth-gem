module Yorchauth
  class User < ApplicationRecord
    validates :email, presence: true
  end
end
