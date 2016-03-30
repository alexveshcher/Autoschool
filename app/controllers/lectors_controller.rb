class LectorsController < ApplicationController
  before_action :set_lector, only: [:show, :edit, :update, :destroy]

  def index
    @lectors = Lector.all
  end

  def show
  end

  def new
    @lector = Lector.new
  end

  def edit

  end

  def create
    @lector = Lector.new(lector_params)

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
      if @lector.update(lector_params)
        format.html { redirect_to @lector, notice: 'Lector was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @lector.destroy
    respond_to do |format|
      format.html { redirect_to lectors_url, notice: 'Lector was successfully destroyed.' }
    end
  end

  private
  def set_lector
    @lector = Lector.find(params[:id])
  end

  def lector_params
    params.require(:lector).permit(:lastname, :firstname, :patronymic, :phone, :born)
  end
end
