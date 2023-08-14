require 'rails_helper'

RSpec.describe 'operations#index', type: :feature do
  before(:each) do
    @user = User.create(name: 'Salman', email: 'fpsapc@gmail.com', password: '123456')
    @group = Group.create(icon: 'icon.png', name: 'Group', author_id: @user.id)
    @operation = Operation.create(name: 'Transaction', amount: '100', group_id: @group.id, author_id: @user.id)

    visit new_user_session_path
    fill_in 'Email', with: 'fpsapc@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    visit(new_group_operation_path(@group))
  end

  context 'Test operation page' do
    it 'I can access this page if user is connected' do
      expect(page).to have_content 'TRANSACTIONS'
      expect(page).to have_content 'ADD A NEW TRANSACTION'
    end

    scenario 'confirm that the page has a form' do
      expect(page).to have_css('form')
    end

    scenario 'confirm that the form has a name field' do
      expect(page).to have_css('input#operation_name')
    end

    scenario 'confirm that the form has an amount field' do
      expect(page).to have_css('input#operation_amount')
    end

    scenario 'confirm that the form has a submit button' do
      expect(page).to have_css('input[type=submit]')
    end
  end
end
