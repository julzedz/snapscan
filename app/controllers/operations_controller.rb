class OperationsController < ApplicationController
  before_action :set_operation, only: %i[show update destroy]

  def index
    @group = Group.find(params[:group_id])
    @operations = Operation.where(group_id: @group.id).order(id: :desc)
    @total_amount = @operations.sum(:amount)
  end

  def new
    @group = Group.find(params[:group_id])
    @operation = Operation.new
  end

  def create
    @group = Group.find(params[:group_id])
    @operation = Operation.new(operation_params)
    @operation.group_id = @group.id
    @operation.author_id = current_user.id

    if @operation.save
      redirect_to group_path(@group), notice: 'Transaction was successfully created.'
    else
      render :new, alert: 'Failed to add transaction'
    end
  end

  def destroy
    @operation = Operation.find(params[:id])

    if @operation.destroy
      redirect_to group_operations_path, notice: 'Transaction was successfully destroyed.'
    else
      render :index, alert: 'Failed to remove transaction'
    end
  end

  private

  def set_operation
    @item = Operation.find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:name, :amount)
  end
end
