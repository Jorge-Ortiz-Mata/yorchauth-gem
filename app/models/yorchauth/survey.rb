module Yorchauth
  class Survey < ApplicationRecord
    validates :name, presence: true
  end
end
