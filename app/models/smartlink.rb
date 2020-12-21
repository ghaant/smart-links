class Smartlink < ApplicationRecord
  before_save :downcase_slug

  validates :slug, presence: true,
                   length: { maximum: 50 },
                   format: { with: VALID_SLUG },
                   uniqueness: true

  has_many :redirections, dependent: :destroy
  belongs_to :user

  private

  def downcase_slug
    slug.downcase!
  end
end
