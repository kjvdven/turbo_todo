class Task < ApplicationRecord
  after_create_commit :broadcast_create
  after_update_commit :broadcast_update
  after_destroy_commit :broadcast_destroy

  # broadcasts_to ->(task) { :tasks }, inserts_by: :prepend

  enum :status, { in_progress: "in_progress", completed: "completed",  archived: "archived" }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :status, inclusion: { in: statuses.keys }

  scope :ordered, -> { order(id: :desc) }

  private
  def broadcast_create
    broadcast_prepend_to "tasks", target: "in_progress_tasks"
  end

  def broadcast_update
    if saved_change_to_status?
      broadcast_remove_to "tasks"
      broadcast_prepend_to "tasks", target: completed? ? "completed_tasks" : "in_progress_tasks"
    else
      broadcast_replace_to "tasks"
    end
  end

  def broadcast_destroy
    broadcast_remove_to "tasks"
  end
end
