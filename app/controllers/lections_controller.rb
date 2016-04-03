class LectionsController < ApplicationController
  before_action :set_lection, only: [:show, :edit, :update, :destroy]

  def index
    @lections = Lection.all
  end

  def show
  end

  def new
    @lection = Lection.new
  end

  def edit

  end

  def create
    @lection = Lection.new(lection_params)

    respond_to do |format|
      if @lection.save
        format.html { redirect_to @lection, notice: 'Lection was successfully created.' }
        #format.json { render :show, status: :created, location: @lection }
      else
        format.html { render :new }
        #format.json { render json: @lection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lection.update(lection_params)
        format.html { redirect_to @lection, notice: 'Lection was successfully updated.' }
        format.json { render :show, status: :ok, location: @lection }
      else
        format.html { render :edit }
        format.json { render json: @lection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lection.destroy
    respond_to do |format|
      format.html { redirect_to lections_url, notice: 'Lection was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
  def set_lection
    @lection = Lection.find(params[:id])
  end

  def lection_params
    params.require(:lection).permit(:lector_id, :group_id, :lection_time, :lection_num)
  end
end
