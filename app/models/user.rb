class User < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  has_many :smartlinks, dependent: :destroy

  private

  def downcase_email
    email.downcase!
  end
end
