class Language < ApplicationRecord
  before_save :set_default

  has_many :redirections, dependent: :destroy

  private

  def set_default
    self.default = true if code == 'en'
  end
end
