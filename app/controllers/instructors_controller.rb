class InstructorsController < ApplicationController
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]

  def index
    @instructors = Instructor.all
  end

  def show
  end

  def new
    @worker = Worker.new
    @instructor = Instructor.new
  end

  def edit

  end

  def create
    #need to create worker before instructor and pass worker.id to instructor
    @worker = Worker.new(worker_params)
    @instructor = Instructor.new(instructor_params)

    Instructor.transaction do
      @worker.save!

    end
    @instructor.id = @worker.id
    @instructor.save!


    respond_to do |format|
      if @instructor.save
        format.html { redirect_to @instructor, notice: 'Instructor was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @instructor.update(instructor_params) && @worker.update(worker_params)
        format.html { redirect_to @instructor, notice: 'Instructor was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @instructor.destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to instructors_url, notice: 'Instructor was successfully destroyed.' }
    end
  end

  private
  def set_instructor
    @instructor = Instructor.find(params[:id])
    @worker = Worker.find(params[:id])
  end


  def instructor_params
    params.require(:instructor).permit(:licence_expires, :licence_num)
  end
  def worker_params
    params.require(:worker).permit(:lastname, :firstname, :patronymic, :phone, :born)
  end
end
