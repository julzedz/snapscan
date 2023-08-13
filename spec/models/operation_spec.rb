require 'rails_helper'

RSpec.describe Operation, type: :model do
  before(:each) do
    @user = User.create(name: 'Jules', email: 'jules@gmail.com', password: '123456')
    @group = Group.create(icon: 'icon.png', name: 'Group', author_id: @user.id)
    @operation = Operation.create(name: 'transaction', amount: '100', group_id: @group.id, author_id: @user.id)
  end

  describe 'Transaction validations' do
    it 'is valid with valid attributes' do
      expect(@operation).to be_valid
    end

    it 'is not valid without a name' do
      @operation.name = nil
      expect(@operation).to_not be_valid
    end

    it 'is not valid without a user' do
      @operation.author_id = nil
      expect(@operation).to_not be_valid
    end

    it 'is not valid without an amount' do
      @operation.amount = nil
      expect(@operation).to_not be_valid
    end
  end
end
