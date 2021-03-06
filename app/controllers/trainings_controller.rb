class TrainingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_training, only: [:show, :edit, :update, :destroy]

  def index
    if(current_user.role == 'instructor')
            @trainings = Training.joins("INNER JOIN instructors
                                         ON trainings.instructor_id = instructors.id
                                         WHERE instructor_id =#{current_user.uid} ")
      else @trainings = Training.all
    end
  end

  def show
  end

  def new
    @training = Training.new
  end

  def edit

  end

  def create
    @training = Training.new(training_params)

    respond_to do |format|
      if @training.save
        format.html { redirect_to trainings_url, notice: 'Training was successfully created.' }
        #format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new }
        #format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @training.update(training_params)
        format.html { redirect_to trainings_url, notice: 'Training was successfully updated.' }
        format.json { render :show, status: :ok, location: @training }
      else
        format.html { render :edit }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @training.destroy
    respond_to do |format|
      format.html { redirect_to trainings_url, notice: 'Training was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
  def set_training
    @training = Training.find(params[:id])
  end

  def training_params
    params.require(:training).permit(:instructor_id, :vehicle_id, :student_id, :training_time, :duration, :mark, :petrol_usage)
  end
end
