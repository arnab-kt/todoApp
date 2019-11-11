class Todo < ApplicationRecord
  belongs_to :user

  validates :description, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :date, presence: true
  validates :done, inclusion: { in: [true, false] }

end
