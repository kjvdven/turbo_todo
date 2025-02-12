class Task < ApplicationRecord
  broadcasts_to ->(task) { :tasks }, inserts_by: :prepend

  enum :status, { in_progress: "in_progress", completed: "completed",  archived: "archived" }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :status, inclusion: { in: statuses.keys }

  scope :ordered, -> { order(id: :desc) }
end
