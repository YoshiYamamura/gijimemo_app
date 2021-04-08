class Meeting < ApplicationRecord
  belongs_to :user
  has_many :access_permits

  validates :name, presence: true
end
