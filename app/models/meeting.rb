class Meeting < ApplicationRecord
  belongs_to :user
  has_many :access_permits
  has_many :reactions

  validates :name, presence: true

  def self.search(search)
    if search != ""
      Meeting.where('name LIKE(?)', "%#{search}%")
    else
      Meeting.all
    end
  end
end
