class Transcript < ApplicationRecord
  attr_accessor :language, :number_of_people

  belongs_to :user
  has_one_attached :voice_data

  audiofile_mime_types = [/^audio\/.*flac$/, /^audio\/.*mpeg$/, /^audio\/.*wav$/, /^audio\/.*wave$/]
  message_mime_types = '本機能はFLAC, MP3, WAVの音声ファイルに対応しています'

  with_options presence: true do
    validates :name
    validates :transcript
    validates :status
    validates :voice_data, file_content_type: { allow: audiofile_mime_types, message: message_mime_types }
    validates :audio_duration
  end

  def self.search(search)
    if search != ""
      Transcript.where('name LIKE(?)', "%#{search}%")
    else
      Transcript.all
    end
  end
end
