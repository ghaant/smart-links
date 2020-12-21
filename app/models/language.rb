class Language < ApplicationRecord
  before_save :set_default

  validates :code, presence: true, length: { is: 2 }

  has_many :redirections, dependent: :destroy

  private

  def set_default
    self.default = true if code == 'en'
  end
end
