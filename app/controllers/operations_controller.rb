class OperationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @operations = Operation.all
  end
end
