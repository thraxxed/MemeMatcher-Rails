# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string           not null
#  password_digest      :string           not null
#  session_token        :string           not null
#  picture_file_name    :string           not null
#  picture_content_type :string           not null
#  picture_file_size    :integer          not null
#  picture_updated_at   :datetime         not null
#  bio                  :string           not null
#  latitude             :float            not null
#  longitude            :float            not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  validates :username, uniqueness: true

  has_many :likes
  has_many :messages

  has_many :matches1,
  foreign_key: :user1_id,
  primary_key: :id,
  class_name: 'Match'

  has_many :matches2,
  foreign_key: :user2_id,
  primary_key: :id,
  class_name: 'Match'

  before_validation :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
