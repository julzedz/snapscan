class GroupsController < ApplicationController
  before_action :set_group, only: %i[show update destroy]

  def index
    @user = current_user
    @groups = Group.all.where(author_id: current_user.id)
  end

  def create
    add_group = Group.new(group_params)
    add_group.author_id = current_user.id

    if add_group.save
      redirect_to groups_path, notice: 'Category was successfully created'
    else
      render :new, alert: 'Failed to create category'
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: 'Category was successfully updated'
    else
      render :edit, alert: 'Failed to update category'
    end
  end

  # GET /categories/1 or /categories/1.json
  def show
    @group = Group.find(params[:id])
    @operations = Operation.where(group_id: @group.id).order(id: :desc)
    @total_amount = @operations.sum(:amount)
  end

  def destroy
    @group = Group.find(params[:id])

    if @group.destroy
      redirect_to groups_path, notice: 'Category was successfully removed'
    else
      render :index, alert: 'Failed to remove category'
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def determine_layout
    user_signed_in? ? 'application' : 'unauthenticated'
  end

  def group_params
    params.permit(:name, :icon)
  end
end
