class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_todo, only: [:edit, :update, :destroy, :change_status]

  def index
    @filter_params = false
    if params[:date].present?
      @todos = Todo.where(user_id: current_user.id, date: params[:date])
      @filter_params = true
    else
      @todos = current_user.todos
    end
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id

    if @todo.save
      redirect_to todos_path, flash: { notice: "Todo created successfully" }
    else
      flash.now[:alert] = "Failed to create todo"
      render "new"
    end
  end

  def edit

  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path, flash: { notice: "Todo edited successfully" }
    else
      flash.now[:alert] = "Failed to edit todo"
      render "edit"
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path
  end

  def change_status
    if @todo.done
      status=false
    else
      status = true
    end
    @todo.done = status
    @todo.save(validate: false)

    redirect_to todos_path
  end

  def report_parameters

  end

  def generate_report
    binding.pry
    if params[:start_date].blank? || params[:end_date].blank?
      @todos = current_user.todos
    else
      @todos = Todo.where("user_id=#{current_user.id} AND date BETWEEN #{params[:start_date]} to #{params[:end_date]}")
    end
      pdf = ReportPdf.new(@todos)
      send_data pdf.render, filename: "Report", type: "application/pdf", disposition: "inline"
  end

  private

  def todo_params
    params.require(:todo).permit(:description, :date, :done)
  end

  def find_todo
    @todo = Todo.find(params[:id])
  end
end
