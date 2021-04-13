class Meeting < ApplicationRecord
  belongs_to :user
  has_many :access_permits
  has_many :reactions

  validates :name, presence: true
end
