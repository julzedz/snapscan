require 'rails_helper'

RSpec.describe 'group/index', type: :feature do
  before(:each) do
    @user = User.create(name: 'Salman', email: 'fpsapc@gmail.com', password: '123456')
    @group = Group.create(icon: 'icon.png', name: 'Group', author_id: @user.id)
    @operation = Operation.create(name: 'Transaction', amount: '100', group_id: @group.id, author_id: @user.id)

    visit new_user_session_path
    fill_in 'Email', with: 'fpsapc@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it 'I can access this page if user is connected' do
    visit groups_path

    expect(page).to have_content 'CATEGORIES'
    expect(page).to have_content(@group.name)
  end

  it 'I can access this page if user is connected' do
    visit new_group_path
    expect(page).to_not have_content 'CATEGORIES'
    expect(page).to have_content 'ADD A NEW CATEGORY'
    expect(page).to have_css('form')
    expect(page).to have_css('input[type=submit]')
  end
end
