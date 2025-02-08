class Task < ApplicationRecord
  enum :status, { open: "open", completed: "completed" }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :status, inclusion: { in: statuses.keys }
end
