class Account < ApplicationRecord
  validates :name, uniqueness: true
end
