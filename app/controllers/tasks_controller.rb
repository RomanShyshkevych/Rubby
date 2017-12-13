class TasksController < ApplicationController
  #def index
   # @tasks = current_user.tasks.order("importance ASC").all
   #  respond_to do |format|
   #    format.html{render 'tasks/index'}
   #    format.json{render :json => {tasks: @tasks}}
   # end
  #end

  def index
    @tasks = current_user.tasks.order("expiry").all
    respond_to do |format|
      format.html {  }
      format.json { render json: @tasks, status: :ok}
    end
  end

  def create
    current_user.tasks.create( task_create_params)
    redirect_to '/'
  end

  def update
    task = current_user.tasks.find_by(id: params[:id])
    if task && params[:task]
      task.update!(task_update_params)
    end
    redirect_to '/'
  end

  def delete
    task = current_user.tasks.find_by(id: params[:id])
    if task
      task.destroy!
    end
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to '/'
    end
  end

  def task_update_params
    params.require(:task).permit(:name, :description, :importance, :expiry, :done)
  end


  def task_create_params
    params.require(:task).permit(:name, :description, :importance, :expiry, :done)
  end
end

