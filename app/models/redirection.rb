class Redirection < ApplicationRecord
  validates :url, presence: true,
                  length: { minimum: 12 }

  belongs_to :smartlink
  belongs_to :language
end
