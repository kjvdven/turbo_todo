class TasksController < ApplicationController
  def index
    @tasks = Task.open.order(created_at: :desc)
    @completed_tasks = Task.completed.order(created_at: :desc)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :status)
    end
end
