class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete, :accept]

  def index
    @assigned_tasks = current_user.assigned_tasks.includes(:ally)
    @received_tasks = current_user.received_tasks.includes(:user)
  end

  def show
  end

  def new
    @ally = current_user.allies.find(params[:ally_id]) if params[:ally_id]
    @task = current_user.assigned_tasks.build(ally: @ally)
  end

  def create
    @task = current_user.assigned_tasks.build(task_params)
    
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully assigned.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully deleted.'
  end

  def accept
    if @task.pending? && is_recipient?
      @task.accept!
      redirect_to tasks_path, notice: 'Task accepted! You can now complete it.'
    else
      redirect_to tasks_path, alert: 'Unable to accept task.'
    end
  end

  def complete
    Rails.logger.info "[DEBUG] Attempting to complete task: id=#{@task.id}, status=#{@task.status}, recipient=#{is_recipient?}, current_user=#{current_user.id}, ally_user_id=#{@task.ally.ally_user_id}"
    if @task.in_progress? && is_recipient?
      @task.complete!
      Rails.logger.info "[DEBUG] Task completed successfully."
      redirect_to tasks_path, notice: "Task completed! #{@task.points} points awarded."
    else
      Rails.logger.info "[DEBUG] Unable to complete task: status=#{@task.status}, recipient=#{is_recipient?}, current_user=#{current_user.id}, ally_user_id=#{@task.ally.ally_user_id}"
      redirect_to tasks_path, alert: 'Unable to complete task.'
    end
  end

  private

  def set_task
    @task = current_user.assigned_tasks.find_by(id: params[:id])
    unless @task
      @task = Task.joins(:ally).where(id: params[:id], allies: { ally_user_id: current_user.id }).first
    end
    raise ActiveRecord::RecordNotFound unless @task
  end

  def is_recipient?
    @task.ally.ally_user_id == current_user.id
  end

  def task_params
    params.require(:task).permit(:ally_id, :title, :description, :points, :status, :due_date)
  end
end
