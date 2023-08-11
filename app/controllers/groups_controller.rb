class GroupsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_group, only: %i[show update destroy]
  layout :determine_layout

  def index
    @user = current_user
    @groups = current_user.groups.includes(:operations).order(id: :desc)
  end

  def create
    add_group = current_user.groups.new(group_params)

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

  def destroy
    @user = current_user
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
