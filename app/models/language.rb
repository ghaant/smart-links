class Language < ApplicationRecord
  has_many :redirections, dependent: :destroy
end
