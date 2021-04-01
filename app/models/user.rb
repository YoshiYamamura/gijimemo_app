class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  alphabet_number_mix_8 = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}\z/i

  with_options presence: true do
    validates :nickname
    validates :password, format: { with: alphabet_number_mix_8 }
  end

  has_many :meetings
end
