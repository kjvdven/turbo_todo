class TasksController < ApplicationController

  def index
    @tasks = Task.open.order(created_at: :desc)
    @completed_tasks = Task.completed.order(created_at: :desc)
  end
end
