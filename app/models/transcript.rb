class Transcript < ApplicationRecord
  belongs_to :user
  has_one_attached :voice_data
end
