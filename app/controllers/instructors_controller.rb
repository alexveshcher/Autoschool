class InstructorsController < ApplicationController
  load_and_authorize_resource
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]

  def export
    @instructors = Instructor.top3
    respond_to do |format|
      format.html
      format.xlsx {render 'instructors/download'}
    end
  end


  def index
    @instructors = Instructor.all
       respond_to do |format|
          format.html
          format.xlsx {render 'instructors/download'}
          end
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
        #creates new user with role='student', email and password are the same
                User.create!(email: "instructor#{@instructor.id}@gmail.com",
                                                   password: "instructor#{@instructor.id}@gmail.com", role: 'instructor', uid: @instructor.id)
        format.html { redirect_to instructors_path, notice: 'Instructor was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @instructor.update(instructor_params) && @worker.update(worker_params)
        format.html { redirect_to instructors_path, notice: 'Instructor was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    begin
      ActiveRecord::Base.transaction do
        if !(User.find_by(uid: @instructor.id, role: 'instructor').nil?)
          User.find_by(uid: @instructor.id, role: 'instructor').destroy
        end
        @instructor.destroy
        @worker.destroy
      end
      respond_to do |format|
        format.html { redirect_to instructors_url, notice: 'Instructor was successfully destroyed.' }
        end
    rescue => e
        redirect_to instructors_path, alert: "#{e}  You cant delete instructor when he has trainings."
        # something went wrong, transaction rolled back
      end
    #destroy users related to instructor
=begin
    if !(User.find_by(uid: @instructor.id, role: 'instructor').nil?)
        User.find_by(uid: @instructor.id, role: 'instructor').destroy
    end
    @instructor.destroy
    @worker.destroy
=end


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
