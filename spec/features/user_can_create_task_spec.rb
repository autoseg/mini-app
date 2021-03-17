require 'rails_helper'

feature 'User can Create a Task' do

  scenario 'And must be loged in' do
    visit new_task_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  context 'As logged user' do
    let(:user) { create(:user) }

    before do
      login_as(user)
      create(:profile, user: user)

      visit root_path
      click_on 'Create a Task'
    end

    scenario 'Successfully' do
      fill_in 'Title', with: 'Test Title'
      fill_in 'Description', with: 'Test Description'
      select 'High', from: 'Priority'

      click_on 'Save'

      expect(page).to have_content('Task Created!')
      expect(current_path).to eq(task_path(user.tasks.last))
      expect(Task.count).to eq(1)
      expect(Task.last.title).to eq('Test Title')
      expect(Task.last.priority).to eq('high')
      expect(Task.last.description).to eq('Test Description')
    end

    scenario 'And Title must have more than 4 characters' do
      fill_in 'Title', with: 'Te'
      fill_in 'Description', with: 'Test Description'

      click_on 'Save'

      expect(page).to have_content('Title is too short')
      expect(user.tasks).to be_blank
    end

    scenario 'And Title must have less than 21 characters' do
      fill_in 'Title', with: 'T' * 21
      fill_in 'Description', with: 'Test Description'

      click_on 'Save'

      expect(page).to have_content('Title is too long')
      expect(user.tasks).to be_blank
    end

    scenario 'And Description Can\'t be blank' do
      fill_in 'Title', with: 'Te'
      fill_in 'Description', with: ''

      click_on 'Save'

      expect(page).to have_content('Description can\'t be blank')
      expect(user.tasks).to be_blank
    end

    scenario 'And Description must have less than 281 characters' do
      fill_in 'Title', with: 'Te'
      fill_in 'Description', with: 'T' * 281

      click_on 'Save'

      expect(page).to have_content('Description is too long')
      expect(user.tasks).to be_blank
    end

  end

end
