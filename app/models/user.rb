class User < ApplicationRecord
  before_save { self.email = email.downcase }
  
  validates :username, presence: true, length: { minimum: 3, maximum: 15 },
              uniqueness: {case_sensitive: false}
  has_secure_password

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i # const
  validates :email, uniqueness: { case_sensitive: false },
                    presence: true,
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  has_many :messages
end
