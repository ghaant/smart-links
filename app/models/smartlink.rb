class Smartlink < ApplicationRecord
  has_many :redirections, dependent: :destroy
end
