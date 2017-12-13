class Task < ApplicationRecord
  validates :name, length: { minimum: 3 }
  enum :importance => [:high, :medium, :low]
  belongs_to :user
end
