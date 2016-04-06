class WorkersController < ApplicationController
  load_and_authorize_resource
  before_action :set_worker, only: [:show, :edit, :update, :destroy]

  def index
    @workers = Worker.all
  end

  def show
  end

  def new
    @worker = Worker.new
  end

  def edit

  end

  def create
    @worker = Worker.new(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: 'Worker was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @worker.update(worker_params)
        format.html { redirect_to @worker, notice: 'Worker was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_url, notice: 'Worker was successfully destroyed.' }
    end
  end

  private
  def set_worker
    @worker = Worker.find(params[:id])
  end

  def worker_params
    params.require(:worker).permit(:lastname, :firstname, :patronymic, :phone, :born)
  end
end
