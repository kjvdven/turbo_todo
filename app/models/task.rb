class Task < ApplicationRecord
  enum :status, { in_progress: "in_progress", completed: "completed",  archived: "archived" }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :status, inclusion: { in: statuses.keys }
end
