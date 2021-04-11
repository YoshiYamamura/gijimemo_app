class Transcript < ApplicationRecord
  belongs_to :user
  has_one_attached :voice_data

  audiofile_mime_types = [/^audio\/.*flac$/, /^audio\/.*mpeg$/, /^audio\/.*wav$/]
  message_mime_types = 'only FLAC, MP3, WAV are allowed'

  with_options presence: true do
    validates :name
    validates :transcript
    validates :status
    validates :voice_data, file_content_type: { allow: audiofile_mime_types, message: message_mime_types }
  end
end
