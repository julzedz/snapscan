class OperationsController < ApplicationController
  before_action :set_operation, only: %i[show update destroy]

  def index
    @group = Group.find(params[:group_id])
    @operations = Operation.where(group_id: @group.id).order(id: :desc)
    @total_amount = @operations.sum(:amount)
  end

  def create
    @operations = current_user.item.new(item_params)

    if @operations.save
      redirect_to group_operations_path, notice: 'Transaction was successfully created.'
    else
      render :new, alert: 'Failed to add transaction'
    end
  end

  def destroy
    @operations = Item.find(params[:id])

    if @operations.destroy
      redirect_to group_operations_path, notice: 'Transaction was successfully destroyed.'
    else
      render :index, alert: 'Failed to remove transaction'
    end
  end

  private

  def set_operation
    @item = Item.find(params[:id])
  end

  def operation_params
    params.permit(:name, :amount, :group_id)
  end
end
