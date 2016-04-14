class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.get_all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit

  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        #format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        #format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @group.destroy
      respond_to do |format|
        format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      end
    rescue => e
      redirect_to groups_path, alert: 'You cant delete group when it has students yet.'
    end


  end

  private
    def set_group
      @group = Group.get_by_id(params[:id])
    end

    def group_params
      params.require(:group).permit(:starttime)
    end

end
