class Counting < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true
  # validates :c, presence: true
  # validates :amount, presence: true
end
