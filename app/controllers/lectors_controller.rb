class LectorsController < ApplicationController
  before_action :set_lector, only: [:show, :edit, :update, :destroy]

  def index
    @lectors = Lector.all
  end

  def show
  end

  def new
    @worker = Worker.new
    @lector = Lector.new
  end

  def edit

  end

  def create
    #need to create worker before lector and pass worker.id to lector
    @worker = Worker.new(worker_params)
    @lector = Lector.new(lector_params)

    Lector.transaction do
      @worker.save!

    end
    @lector.id = @worker.id
    @lector.save!


    respond_to do |format|
      if @lector.save
        format.html { redirect_to @lector, notice: 'Lector was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @lector.update(lector_params) && @worker.update(worker_params)
        format.html { redirect_to @lector, notice: 'Lector was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @lector.destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to lectors_url, notice: 'Lector was successfully destroyed.' }
    end
  end

  private
  def set_lector
    @lector = Lector.find(params[:id])
    @worker = Worker.find(params[:id])
  end


  def lector_params
    params.require(:lector).permit(:id, :teaches_since)
  end
  def worker_params
    params.require(:worker).permit(:lastname, :firstname, :patronymic, :phone, :born)
  end
end
