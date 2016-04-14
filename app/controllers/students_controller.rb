class StudentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.get_all
  end

  def show
  end

  def new
    @student = Student.new
  end

  def edit

  end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        #creates new user with role='student', email and password are the same
        User.create!(email: "student#{@student.id}@gmail.com",
                     password: "student#{@student.id}@gmail.com", role: 'student', uid: @student.id)
        #format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        #format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #destroy users related to instructor
    if !(User.find_by(uid: @student.id, role: 'student').nil?)
      User.find_by(uid: @student.id, role: 'student').destroy
    end
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
  def set_student
    @student = Student.get_by_id(params[:id])
  end

  def student_params
    params.require(:student).permit(:group_id, :lastname, :firstname, :patronymic,
                                    :born, :reg_date, :phone, :category, :passed_school, :passed_mreo)
  end
end
